{ pkgs, ... }:

let
  gcloud = pkgs.google-cloud-sdk.withExtraComponents (
    with pkgs.google-cloud-sdk.components;
    [
      alpha
      beta
      cloud_sql_proxy
      docker-credential-gcr
      gke-gcloud-auth-plugin
      kubectl
      minikube
      skaffold
    ]
  );
in
{
  home.packages = [
    gcloud
  ];

  # Environment variables for Google Cloud SDK
  home.sessionVariables = {
    # Set the default project (you can override this per-project)
    CLOUDSDK_CORE_PROJECT = "";

    # Set the default compute region
    # CLOUDSDK_COMPUTE_REGION = "us-central1";

    # Set the default compute zone
    # CLOUDSDK_COMPUTE_ZONE = "us-central1-a";

    # Disable usage reporting (optional)
    # CLOUDSDK_CORE_DISABLE_USAGE_REPORTING = "true";

    # Set the default account (you can override this)
    # CLOUDSDK_CORE_ACCOUNT = "";
  };

  # Optional: Add shell completion for gcloud
  programs.zsh.enable = true;
}
