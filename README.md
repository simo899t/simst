# sdust

Typst template package for SDU/IMADA course documents by © Simon Holm.

## Installation

```bash
git clone https://github.com/simo899t/sdust ~/GitHub/sdust
mkdir -p ~/.local/share/typst/packages/local/sdust
ln -s ~/GitHub/sdust ~/.local/share/typst/packages/local/sdust/0.1.0
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
