# Linux Tools Install Scripts

A collection of installer scripts for Linux tools (tested on Ubuntu).

## Available installers

| Tool | Description | Script |
| ---- | ----------- | ------ |
| [LazyVim](installers/lazyvim) | Latest Neovim + LazyVim starter config | `installers/lazyvim/install.sh` |

## Usage

```bash
git clone <this-repo-url>
cd linux-tools-install-script
./installers/<tool>/install.sh
```

See each installer's `README.md` for details.

## Repository structure

```
.
├── README.md
└── installers/
    └── lazyvim/
        ├── install.sh
        └── README.md
```

## Adding a new installer

1. Create `installers/<tool>/` with an `install.sh` and a `README.md`.
2. Make it executable: `chmod +x installers/<tool>/install.sh`
3. Add a row to the **Available installers** table above.
