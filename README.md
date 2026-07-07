# sdust

Typst package with document templates (notes, exercises, exams, projects,
CHI papers) and theorem-style blocks (theorem, definition, example, proof,
corollary) for academic documents. Institution-agnostic — no bundled logo
or branding; pass your own via the `logo:` parameter.

For SDU-specific defaults (logo, university name) and personal math
notation, see [tempst](https://github.com/simo899t/tempst), which builds
on top of this package.

## Installation (local development)

Clone the repo, then symlink it into Typst's local package registry for
your OS:

| OS | Local package registry |
|---|---|
| macOS | `~/Library/Application Support/typst/packages/local` |
| Linux | `~/.local/share/typst/packages/local` (or `$XDG_DATA_HOME/typst/packages/local`) |
| Windows | `%APPDATA%\typst\packages\local` |

**macOS:**
```bash
git clone https://github.com/simo899t/sdust ~/GitHub/sdust
mkdir -p ~/Library/Application\ Support/typst/packages/local/sdust
ln -s ~/GitHub/sdust ~/Library/Application\ Support/typst/packages/local/sdust/0.1.0
```

**Linux:**
```bash
git clone https://github.com/simo899t/sdust ~/GitHub/sdust
mkdir -p ~/.local/share/typst/packages/local/sdust
ln -s ~/GitHub/sdust ~/.local/share/typst/packages/local/sdust/0.1.0
```

**Windows (PowerShell, run as Administrator for symlinks):**
```powershell
git clone https://github.com/simo899t/sdust $HOME\GitHub\sdust
New-Item -ItemType Directory -Force -Path "$env:APPDATA\typst\packages\local\sdust"
New-Item -ItemType SymbolicLink -Path "$env:APPDATA\typst\packages\local\sdust\0.1.0" -Target "$HOME\GitHub\sdust"
```

Or once published, just:

```typst
#import "@preview/sdust:0.1.0": *
```

## Usage

**Without cover page:**
```typst
#import "@local/sdust:0.1.0": *
#show: pageSetup
```

**With cover page:**
```typst
#import "@local/sdust:0.1.0": *
#show: note.with(
  title: "...",
  course: "DM000 — Course Name",
  author: "...",
  date: "..."
)
```

## Templates

| Function | Description |
|---|---|
| `pageSetup` | Base styling, no cover page |
| `note` | Lecture notes |
| `exercise` | Exercise sheets |
| `assignment` | Assignments |
| `project` | Group/solo project reports |
| `exam` | Exam submissions |
| `chi` | ACM CHI paper format |

## Theorem-style blocks

`theorem`, `definition`, `example`, `proof`, `corollary`, `block` — coloured
titled cards, e.g. `#theorem[...]`.

## Other helpers

`graph`/`dirgraph` (node/edge diagrams), `tree` (tidy-tree wrapper), `pseudo`
(pseudocode block), `prooftree` (curryst rule), `mycases`, `bib`.
