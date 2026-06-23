# sdu-notes

Typst template package for SDU/IMADA course documents by © Simon Holm.

## Installation

```bash
git clone https://github.com/simo899t/sdu-notes ~/GitHub/sdu-notes
mkdir -p ~/.local/share/typst/packages/local/sdu-notes
ln -s ~/GitHub/sdu-notes ~/.local/share/typst/packages/local/sdu-notes/0.1.0
```

## Usage

**Without cover page:**
```typst
#import "@local/sdu-notes:0.1.0": *
#show: pageSetup
```

**With cover page:**
```typst
#import "@local/sdu-notes:0.1.0": *
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