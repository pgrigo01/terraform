package provider

import (
	"context"
	"os"

	"github.com/hashicorp/terraform-plugin-framework/datasource"
	"github.com/hashicorp/terraform-plugin-framework/path"
	"github.com/hashicorp/terraform-plugin-framework/provider"
	"github.com/hashicorp/terraform-plugin-framework/provider/schema"
	"github.com/hashicorp/terraform-plugin-framework/resource"
	"github.com/hashicorp/terraform-plugin-framework/types"
)

var (
	_ provider.Provider = &cloudlabProvider{}
)

func New(version string) func() provider.Provider {
	return func() provider.Provider {
		return &cloudlabProvider{
			version: version,
		}
	}
}

type cloudlabProvider struct {
	version string
}

func (p *cloudlabProvider) Metadata(_ context.Context, _ provider.MetadataRequest, resp *provider.MetadataResponse) {
	resp.TypeName = "cloudLab"
	resp.Version = p.version
}

type cloudlabProviderModel struct {
	Credentials_path types.String `tfsdk:"credentials_path"`
	Project          types.String `tfsdk:"project"`
	Workspace        types.String `tfsdk:"workspace"`
}

func (p *cloudlabProvider) Schema(_ context.Context, _ provider.SchemaRequest, resp *provider.SchemaResponse) {
	resp.Schema = schema.Schema{
		Attributes: map[string]schema.Attribute{
			"credentials_path": schema.StringAttribute{
				Required:  true,
				Sensitive: true,
			},
			"project": schema.StringAttribute{
				Required:  true,
				Sensitive: true,
			},
			"workspace": schema.StringAttribute{
				Optional:    true,
				Description: "The Terraform workspace to use. Defaults to 'default'.",
			},
		},
	}
}

func (p *cloudlabProvider) Configure(ctx context.Context, req provider.ConfigureRequest, resp *provider.ConfigureResponse) {
	var config cloudlabProviderModel
	diags := req.Config.Get(ctx, &config)
	resp.Diagnostics.Append(diags...)
	if resp.Diagnostics.HasError() {
		return
	}

	if config.Credentials_path.IsUnknown() {
		resp.Diagnostics.AddAttributeError(
			path.Root("credentials_path"),
			"Unknown credentials path",
			"Cannot proceed without a credentials path.",
		)
	}
	if config.Project.IsUnknown() {
		resp.Diagnostics.AddAttributeError(
			path.Root("project"),
			"Unknown project",
			"Cannot proceed without a project.",
		)
	}
	if resp.Diagnostics.HasError() {
		return
	}

	credentials_path := os.Getenv("CLOUDLAB_CREDENTIALS_PATH")
	if !config.Credentials_path.IsNull() {
		credentials_path = config.Credentials_path.ValueString()
	}

	project := os.Getenv("CLOUDLAB_PROJECT")
	if !config.Project.IsNull() {
		project = config.Project.ValueString()
	}

	workspace := "default"
	if !config.Workspace.IsNull() && config.Workspace.ValueString() != "" {
		workspace = config.Workspace.ValueString()
	}

	if credentials_path == "" {
		resp.Diagnostics.AddAttributeError(
			path.Root("credentials_path"),
			"Missing credentials path",
			"Set the credentials path in the configuration or use the CLOUDLAB_CREDENTIALS_PATH env var.",
		)
	}
	if project == "" {
		resp.Diagnostics.AddAttributeError(
			path.Root("project"),
			"Missing CloudLab project",
			"Set the project in the configuration or use the CLOUDLAB_PROJECT env var.",
		)
	}
	if resp.Diagnostics.HasError() {
		return
	}

	client := Client{
		credentialsPath: credentials_path,
		project:         project,
		workspace:       workspace,
	}
	resp.DataSourceData = client
	resp.ResourceData = client
}

func (p *cloudlabProvider) DataSources(_ context.Context) []func() datasource.DataSource {
	return nil
}

func (p *cloudlabProvider) Resources(_ context.Context) []func() resource.Resource {
	return []func() resource.Resource{
		CloudLabExperimentResource,
		CloudLabVlanResource,
	}
}
