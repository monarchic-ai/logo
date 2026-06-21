<div align="center">
  <img width="400" src="./logo.svg">
</div>

# Monarchic Logo

This repo packages the Monarchic logo source and PNG export tooling. The vector source is derived from the shared favicon in `monarchic-webapp/monarchic-webapp/public/favicon.svg` and `website/website/public/favicon.svg`.

## Exports

Generate all PNG variants:

```bash
nix run .#export-pngs
```

The script exports light and dark logo variants at 64, 128, 192, 256, 460, 512, and 1024 pixels, with both transparent and opaque backgrounds.
