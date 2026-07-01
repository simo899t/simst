# simst

Typst template package for SDU/IMADA course documents by © Simon Holm.

## Installation

```bash
git clone https://github.com/simo899t/simst ~/GitHub/sydst
mkdir -p ~/.local/share/typst/packages/local/simst
ln -s ~/GitHub/simst ~/.local/share/typst/packages/local/simst/0.1.0
```

## Usage

**Without cover page:**
```typst
#import "@local/simst:0.1.0": *
#show: pageSetup
```

**With cover page:**
```typst
#import "@local/simst:0.1.0": *
#show: note.with(title: "...", course: "DM000 — Course Name", author: "...", date: "...")
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
