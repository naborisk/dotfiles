#!/usr/bin/env zsh
# ============================================================================
# Disable telemetry for all known CLI tools and frameworks
# Reference: https://github.com/beatcracker/toptout
# ============================================================================

# --- Universal ---
export DO_NOT_TRACK=1                                    # https://consoledonottrack.com/

# --- Cloud & Infrastructure ---
export AZURE_CORE_COLLECT_TELEMETRY=0                    # Azure CLI
export SAM_CLI_TELEMETRY=0                               # AWS SAM CLI
export CLOUDSDK_CORE_DISABLE_USAGE_REPORTING=true         # Google Cloud SDK
export CHECKPOINT_DISABLE=1                              # HashiCorp (Terraform, Consul, Nomad, Packer)
export TEEM_DISABLE=true                                 # HashiCorp TEEM
export ARM_DISABLE_TERRAFORM_PARTNER_ID=true             # Terraform Azure partner telemetry
export PULUMI_SKIP_UPDATE_CHECK=true                     # Pulumi
export INFRACOST_SELF_HOSTED_TELEMETRY=false             # Infracost
export INFRACOST_SKIP_UPDATE_CHECK=true                  # Infracost update check
export EARTHLY_DISABLE_ANALYTICS=1                       # Earthly CI/CD
export KICS_COLLECT_TELEMETRY=0                          # Checkmarx KICS
export WERF_TELEMETRY=0                                  # werf CI/CD

# --- .NET / Microsoft ---
export DOTNET_CLI_TELEMETRY_OPTOUT=true                  # .NET CLI
export DOTNET_INTERACTIVE_CLI_TELEMETRY_OPTOUT=1         # .NET Interactive
export DOTNET_SVCUTIL_TELEMETRY_OPTOUT=1                 # dotnet-svcutil
export DOTNET_UPGRADEASSISTANT_TELEMETRY_OPTOUT=1        # .NET Upgrade Assistant
export MLDOTNET_CLI_TELEMETRY_OPTOUT=true                # ML.NET CLI
export MSSQL_CLI_TELEMETRY_OPTOUT=true                   # MSSQL CLI
export VSTEST_TELEMETRY_OPTEDIN=0                        # Visual Studio Test
export TESTINGPLATFORM_TELEMETRY_OPTOUT=1                # Microsoft Testing Platform
export POWERSHELL_TELEMETRY_OPTOUT=1                     # PowerShell
export POWERSHELL_UPDATECHECK=Off                        # PowerShell update check
export NUKE_TELEMETRY_OPTOUT=1                           # NUKE Build
export ORYX_DISABLE_TELEMETRY=true                       # Microsoft Oryx
export MOBILE_CENTER_TELEMETRY=off                       # VS App Center CLI
export PROSE_TELEMETRY_OPTOUT=1                          # Microsoft PROSE SDK

# --- JavaScript / Node.js ---
export NEXT_TELEMETRY_DISABLED=1                         # Next.js
export ASTRO_TELEMETRY_DISABLED=1                        # Astro
export NUXT_TELEMETRY_DISABLED=1                         # Nuxt
export GATSBY_TELEMETRY_DISABLED=1                       # Gatsby
export STORYBOOK_DISABLE_TELEMETRY=1                     # Storybook
export STORYBOOK_ENABLE_CRASH_REPORTS=0                  # Storybook crash reports
export TURBO_TELEMETRY_DISABLED=1                        # Turborepo
export CARBON_TELEMETRY_DISABLED=1                       # IBM Carbon
export CUBEJS_TELEMETRY=false                            # Cube.js
export EXPO_NO_TELEMETRY=1                               # Expo / React Native
export HINT_TELEMETRY=off                                # webhint
export YARN_ENABLE_TELEMETRY=0                           # Yarn
export STRAPI_TELEMETRY_DISABLED=true                    # Strapi
export STRAPI_DISABLE_UPDATE_NOTIFICATION=true           # Strapi update
export NC_DISABLE_TELE=1                                 # NocoDB
export SLS_TELEMETRY_DISABLED=1                          # Serverless Framework
export SLS_TRACKING_DISABLED=1                           # Serverless Framework tracking
export WRANGLER_SEND_METRICS=false                       # Cloudflare Wrangler
export NG_CLI_ANALYTICS=false                            # Angular CLI

# --- Package Managers & Build Tools ---
export HOMEBREW_NO_ANALYTICS=1                           # Homebrew
export COCOAPODS_DISABLE_STATS=true                      # CocoaPods
export VCPKG_DISABLE_METRICS=1                           # vcpkg
export CHOOSENIM_NO_ANALYTICS=1                          # choosenim / Nim

# --- Languages & Runtimes ---
export GOTELEMETRY=off                                   # Go

# --- DevOps / Deployment ---
export VAGRANT_CHECKPOINT_DISABLE=1                      # Vagrant
export VAGRANT_BOX_UPDATE_CHECK_DISABLE=1                # Vagrant box update
export SCOUT_DISABLE=1                                   # Scout APM / Telepresence
export CHEF_TELEMETRY_OPT_OUT=1                          # Chef
export FASTLANE_OPT_OUT_USAGE=YES                        # Fastlane
export SFDX_DISABLE_TELEMETRY=true                       # Salesforce DX CLI
export SF_DISABLE_TELEMETRY=true                         # Salesforce CLI
export DECK_ANALYTICS=off                                # decK / Kong
export TUIST_STATS_OPT_OUT=1                             # Tuist

# --- AI / ML ---
export GEMINI_TELEMETRY_ENABLED=false                    # Google Gemini CLI
export HF_HUB_DISABLE_TELEMETRY=1                       # Hugging Face Hub
export RASA_TELEMETRY_ENABLED=false                      # Rasa
export DAGSTER_DISABLE_TELEMETRY=1                       # Dagster

# --- Databases ---
export MEILI_NO_ANALYTICS=true                           # Meilisearch
export INFLUXD_REPORTING_DISABLED=true                   # InfluxDB
export HASURA_GRAPHQL_ENABLE_TELEMETRY=false             # Hasura

# --- Stripe ---
export STRIPE_TELEMETRY_OPTOUT=1                         # Stripe SDK
export STRIPE_CLI_TELEMETRY_OPTOUT=1                     # Stripe CLI

# --- IDE / Editor ---
export GH_NO_TELEMETRY=1                                # GitHub CLI

# --- Other ---
export STNOUPGRADE=1                                     # Syncthing
export AUTOMATEDLAB_TELEMETRY_OPTOUT=1                   # AutomatedLab
export ET_NO_TELEMETRY=1                                 # Eternal Terminal
export ARDUINO_METRICS_ENABLED=false                     # Arduino CLI
export APOLLO_TELEMETRY_DISABLED=1                       # Apollo GraphQL
export SE_AVOID_STATS=true                               # Selenium Manager
export DASH_DISABLE_TELEMETRY=1                          # Plotly Dash
export RAILWAY_NO_TELEMETRY=1                            # Railway CLI
export REDGATE_DISABLE_TELEMETRY=true                    # Redgate Flyway
export F5_ALLOW_TELEMETRY=false                          # F5 BIG-IP

# --- Command-based opt-outs (run once) ---
# GCloud: gcloud config set disable_usage_reporting true
# Netlify:
if command -v 'netlify' >/dev/null 2>&1; then
  'netlify' --telemetry-disable >/dev/null 2>&1
fi
