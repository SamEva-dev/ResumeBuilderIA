#!/usr/bin/env bash
set -e

# (Optionnel) accélère un peu, évite la première expérience
export DOTNET_SKIP_FIRST_TIME_EXPERIENCE=1
# (Optionnel) si tu n'as pas besoin de la globalisation ICU
export DOTNET_SYSTEM_GLOBALIZATION_INVARIANT=1

# Installe le SDK .NET 9 dans $HOME/.dotnet
curl -sSL https://dot.net/v1/dotnet-install.sh -o dotnet-install.sh
bash dotnet-install.sh --channel 9.0 --install-dir "$HOME/.dotnet"

export PATH="$HOME/.dotnet:$PATH"
dotnet --info

# Build & publish Blazor WASM
dotnet restore
dotnet publish ResumeBuilderIA/ResumeBuilderIA.csproj -c Release -o build

# Redirects SPA
echo "/*  /index.html  200" > build/wwwroot/_redirects
