// ══════════════════════════════════════════════════════
// IMPORTS
// ══════════════════════════════════════════════════════

#import "@preview/wordometer:0.1.5": word-count as _word-count, total-words as totalwords
#let word-count = _word-count
#let total-words = totalwords
#import "@preview/plotsy-3d:0.2.1": plot-3d-surface
#import "@preview/lovelace:0.3.0": *
#import "@preview/tdtr:0.5.2" : *
#import "@preview/h-graph:0.1.0": *
#import "@preview/cetz:0.3.4": canvas, draw
#import "@preview/curryst:0.6.0": rule as _curryst-rule, prooftree as _curryst-prooftree
#import "@preview/codly:1.3.0": codly, codly-init
#import "@preview/codly-languages:0.1.10": codly-languages
#let dirgraph(src) = h-graph(src, polar-render)


// ══════════════════════════════════════════════════════
// BASE STYLE
// ══════════════════════════════════════════════════════

#let base-style(body) = {
  show: _word-count
  set text(font: "Computer Modern", size: 12pt)
  set heading(numbering: "1.1")
  set enum(numbering: "1.")
  set math.equation(numbering: none)
  set math.mat(delim: "[", gap: 0.3em)
  set par(justify: true)
  set image(width: 30em)
  show grid: it => {
    set image(width: auto)
    it
  }
  show raw.where(block: true): it => {
    set text(font: ("Menlo", "DejaVu Sans Mono"), size: 9.5pt)
    let lang = it.lang
    std.block(
      breakable: false,
      width: 100%,
      {
        it
        if lang != none and lang != "" {
          place(
            top + right,
            dx: -4pt,
            dy: 4pt,
            box(
              fill: rgb("#4a5568"),
              inset: (x: 5pt, y: 2pt),
              radius: 2pt,
              text(size: 7pt, weight: "bold", fill: white, font: "Times New Roman", upper(lang)),
            ),
          )
        }
      },
    )
  }
  show: codly-init
  codly(
    languages: codly-languages,
    zebra-fill: none,
    display-name: false,
    display-icon: false,
    radius: 2pt,
    inset: (left: 6pt, right: 6pt, top: 4pt, bottom: 4pt),
    stroke: 0.5pt + rgb("#cccccc"),
    fill: rgb("#fafafa"),
  )
  show raw.where(block: false): it => box(
    fill: rgb("#eeeeee"),
    inset: (x: 3pt, y: 0pt),
    outset: (y: 3pt),
    radius: 2pt,
    text(fill: rgb("#1c1e26"), font: ("Menlo", "DejaVu Sans Mono"), size: 9pt, it),
  )
  body
}

#let bib = bibliography.with(style: "chicago-author-date")

#let pageSetup(body) = {
  set page(paper: "us-letter", margin: (left: 3cm, right: 3cm, top: 2cm, bottom: 2cm))
  base-style(body)
}


// ══════════════════════════════════════════════════════
// CODE LANGUAGE SHORTCUTS
// ══════════════════════════════════════════════════════

#let hscode(x) = raw(x, lang: "hs")   // Haskell inline code
#let pycode(x) = raw(x, lang: "py")   // Python inline code  (use pycode, not py — py = ∂y)
// Legacy aliases kept for compatibility
#let hs = hscode


// ══════════════════════════════════════════════════════
// MATH SHORTHANDS — general
// ══════════════════════════════════════════════════════

#let abc = enum.with(numbering: "(a)", spacing: 1.5em)
#let evaluated(expr, size: 100%) = $lr(#expr|, size: #size)$
#let u(x) = underline(x)
#let b(x) = bold(x)
#let i(x) = emph[x]
#let yes = $checkmark$
#let no = $crossmark$
#let pm = $plus.minus$
#let absurd = $bot$
#let QED = [#h(1fr) $square$]
#let IH = [*_IH_*]
#let fill = [#h(1fr)]   // horizontal fill (use #fill, not #f, to avoid f-in-math clashes)

// Logic / sets
#let term(p,q) = $#p "all" #q$
#let sent(p, q, mid: none) = if mid == none { $"All" #p #h(0.4em) #q$ } else { $"All" #p #mid #q$ }
#let allare(p,q) = $"All" #p "are" #q$
#let ip(x) = $[|#x|]$
#let pow(x) = $cal(P)(#x)$
#let psubset = $subset$
#let subset = $subset.eq$
#let cap = $inter$
#let cup = $union$
#let mid = "|"
#let imp = $=>$
#let iimp = $==>$
#let bi = $<=>$
#let bii = $<==>$
#let ent = symbol("⊨", ("not", "⊭"))
#let prov = symbol("⊢", ("not", "⊬"))
#let lang = $chevron.l$
#let rang = $chevron.r$
#let pplus = $plus.double$
#let ppplus = $plus.triple$
#let model = $cal(M)$

// Common abbreviations / operators
#let def = $=^"def"$
#let wrt = $w.r.t$
#let ie = $i.e.$
#let eg = $e.g.$
#let Der = "Der"
#let apx = $approx$
#let bool = [Bool]
#let st = $s.t quad$
#let to = $->$
#let from = $tilde$
#let where = $quad "where"$
#let since = $quad "since"$
#let given = $quad "given"$
#let iff = $quad"if" $
#let otherwise = $quad "otherwise"$
#let bigo(x) = $cal(O)(#x)$
#let smallo(x) = $cal(o)(#x)$
#let adj(x) = $"adj"(#x)$
#let sign(a) = $"sign"(#a)$
#let tran(x) = $#x^sans(T)$
#let inv(x) = $#x^sans(-1)$
#let Astar = $A^star$
#let pred(a) = $accent(#a,\^)$
#let ubar(a) = $accent(#a, \u{0331})$

// Spacing helpers
#let qquad = $quad quad$
#let qqquad = $quad quad quad$
#let qqqquad = $quad quad quad quad$

// Coloured math
#let redmath(x) = text(fill: red, $#x$)
#let bluemath(x) = text(fill: blue, $#x$)
#let greenmath(x) = text(fill: green, $#x$)

// Optimisation
#let maxi(..args) = if args.pos().len() == 0 {
  $op("maximize")$
} else {
  $limits(op("maximize"))_(#args.pos().first())$
}
#let mini(..args) = if args.pos().len() == 0 {
  $op("minimize")$
} else {
  $limits(op("minimize"))_(#args.pos().first())$
}
#let supremum(x) = $op("supremum", limits: #true)_(#x)$
#let diag(x) = $"diag"(#x)$

// ML / activation
#let softmax(x) = $"softmax"(#x)$
#let ReLU(x) = $"ReLU"(#x)$
#let GeLU(x) = $"GeLU"(#x)$
#let loss = $cal(L)$
#let gaus = $cal(N)$

// Big operators
#let int(a,b,c) = $integral_(#a)^(#b) #c$
#let prod(a,b,c) = $product_(#a)^(#b) #c$
#let summ(a,b,c) = $sum_(#a)^(#b) #c$
#let limm(a) = $lim_(#a)$

// Common function applications
#let fx = $f(x)$
#let gx = $g(x)$
#let hx = $h(x)$


// ══════════════════════════════════════════════════════
// CALCULUS NOTATION
// ══════════════════════════════════════════════════════

// Differentials
#let dx = $dif x$
#let dy = $dif y$
#let dz = $dif z$
#let dvar(x) = $dif #x$
#let px = $partial x$
#let py = $partial y$
#let pz = $partial z$
#let pvar(x) = $partial #x$

// Ordinary derivatives
#let ddx = $dif/(dif x)$                          // d/dx  (operator)
#let ddy = $dif/(dif y)$                          // d/dy  (operator)
#let ddz = $dif/(dif z)$                          // d/dz  (operator)
#let dd(x) = $dif/(dif #x)$                       // d/d(var)  e.g. dd(t)
#let dv(f, x) = $(dif #f)/(dif #x)$               // df/dx  e.g. dv(f,x)
#let dvn(f, x, n) = $(dif^#n #f)/(dif #x^#n)$     // dⁿf/dxⁿ  e.g. dvn(f,x,2)

// Partial derivatives
#let ppx = $partial/(partial x)$
#let ppy = $partial/(partial y)$
#let ppz = $partial/(partial z)$
#let pp(x) = $partial/(partial #x)$                            // ∂/∂(var)  e.g. pp(y)
#let ppv(f, x) = $(partial #f)/(partial #x)$                    // ∂f/∂x  e.g. ppv(f,x)
#let pvn(f, x, n) = $(partial^#n #f)/(partial #x^#n)$          // ∂ⁿf/∂xⁿ  e.g. pvn(f,x,2)
#let pvm(f, x, y) = $(partial^2 #f)/(partial #x partial #y)$   // ∂²f/∂x∂y  mixed partial

// Hessian
#let hess2(f) = $mat(
  (partial^2 #f)/(partial x^2), (partial^2 #f)/(partial x partial y);
  (partial^2 #f)/(partial y partial x), (partial^2 #f)/(partial y^2)
)$
#let hess(f) = $mat(
  (partial^2 #f)/(partial x_1^2), dots.c, (partial^2 #f)/(partial x_1 partial x_n);
  dots.v, dots.down, dots.v;
  (partial^2 #f)/(partial x_n partial x_1), dots.c, (partial^2 #f)/(partial x_n^2)
)$

// Gradient / Laplacian
#let nf(g) = $nabla f(#g)$        // ∇g for any g  e.g. nf(f), nf($f$)
#let nf = $nabla f$         // ∇f  (shorthand constant)
#let nnf(x) = $nabla^2 f(#x)$  // Laplacian of f


// ══════════════════════════════════════════════════════
// SYMBOL ALIASES
// ══════════════════════════════════════════════════════

#let phi = $phi.alt$
#let eps = $epsilon$
#let Eps = $Epsilon$
#let del = $delta$
#let Del = $Delta$
#let gam = $gamma$
#let Gam = $Gamma$
#let lam = $lambda$
#let dag = $dagger$
#let phid = $phi^dag$
#let Gamd = $Gam^dag$
#let var = $sigma^2$
#let cov = $Sigma$


// ══════════════════════════════════════════════════════
// PROOF TREES  (curryst)
// ══════════════════════════════════════════════════════

#import "@preview/curryst:0.6.0": rule, prooftree, rule-set

// Pseudocode
#let pseudo = pseudocode-list


// ══════════════════════════════════════════════════════
// UTILITIES
// ══════════════════════════════════════════════════════

#let _fmt-authors(author) = {
  if type(author) == str { author }
  else { author.join(" · ") }
}

#let group-by-pairs(elements) = {
  let lefts = elements
    .enumerate()
    .filter(((index, _)) => calc.rem(index, 2) == 0)
    .map(((_, element)) => element)
  let rights = elements
    .enumerate()
    .filter(((index, _)) => calc.rem(index, 2) == 1)
    .map(((_, element)) => element)
  lefts.zip(rights)
}

// Cases helper: alternating value/condition pairs.
// #mycases($x$, $x > 0$, $-x$, $x <= 0$)
// Optional word: prefix for conditions (e.g. word: "if")
#let mycases(..cases, word: none) = {
  let cases = group-by-pairs(cases.pos())
    .map(((value, condition)) => {
      if word != none {
        $#value quad &#word #condition$
      } else {
        $#value quad & #condition$
      }
    })
  math.cases(..cases)
}


// ══════════════════════════════════════════════════════
// CARD COMPONENTS
// ══════════════════════════════════════════════════════

// Internal base: coloured header bar + tinted body.
#let _titled-card(
  title: none,
  width: 100%,
  header-fill: rgb("#334155"),
  body-fill: rgb("#f8fafc"),
  border: rgb("#d8dde6"),
  body-text-fill: rgb("#1c1e26"),
  body-font: auto,
  body-size: 10.5pt,
  body-leading: 0.65em,
  content,
) = std.block(
  width: width,
  stroke: 0.5pt + border,
  radius: 2pt,
  clip: true,
  {
    if title != none {
      std.block(
        width: 100%,
        above: 0pt,
        below: 0pt,
        fill: header-fill,
        inset: (left: 14pt, right: 14pt, top: 8pt, bottom: 8pt),
        text(fill: white, weight: "bold", size: 10.5pt, title),
      )
    }
    std.block(
      width: 100%,
      above: 0pt,
      below: 0pt,
      fill: body-fill,
      inset: (left: 14pt, right: 14pt, top: 10pt, bottom: 10pt),
      {
        set par(leading: body-leading)
        set text(fill: body-text-fill, size: body-size, ..(if body-font == auto { (:) } else { (font: body-font) }))
        content
      },
    )
  },
)

// gray default block
#let block(title: none, width: 100%, content) = _titled-card(
  title: title, width: width,
  header-fill: rgb("#6b7280"), body-fill: rgb("#f3f4f6"),
  border: rgb("#d1d5db"), body-text-fill: rgb("#1f2937"),
  content,
)

// blue theorem
#let theorem(title: "Theorem", width: 100%, content) = _titled-card(
  title: title, width: width,
  header-fill: rgb("#1565c0"), body-fill: rgb("#ecf3fc"),
  border: rgb("#b3cdeb"), body-text-fill: rgb("#0d2e57"),
  content,
)

// green definition
#let definition(title: "Definition", width: 100%, content) = _titled-card(
  title: title, width: width,
  header-fill: rgb("#2e7d32"), body-fill: rgb("#ecfdf5"),
  border: rgb("#a7f3d0"), body-text-fill: rgb("#14532d"),
  content,
)

// red example
#let example(title: "Example", width: 100%, content) = _titled-card(
  title: title, width: width,
  header-fill: rgb("#c62828"), body-fill: rgb("#fdeced"),
  border: rgb("#f2b9bc"), body-text-fill: rgb("#5a1212"),
  content,
)


// ══════════════════════════════════════════════════════
// DOCUMENT TEMPLATES
// ══════════════════════════════════════════════════════

#let default-title  = "Untitled Document"
#let default-course = "University"
#let default-author = "Firstname Lastname"
#let default-date   = "16/12/2002"

// ── note ─────────────────────────────────────────────
#let note(
  title: default-title,
  author: default-author,
  course: default-course,
  date: default-date,
  outline: true,
  outline-depth: none,
  ..args,
) = {
  let body = args.pos().at(0, default: [])
  set page(paper: "us-letter", margin: (left: 3cm, right: 3cm, top: 3cm, bottom: 3cm))
  align(center,
    stack(
      spacing: 0pt,
      v(1.2cm),
      line(length: 100%, stroke: 3pt + rgb("#2c5aa0")),
      v(1.2em),
      text(size: 9.5pt, fill: rgb("#2c5aa0"), tracking: 2.5pt, weight: "bold")[LECTURE NOTES],
      v(2.5cm),
      text(size: 30pt, weight: "bold")[#title],
      v(1.3em),
      line(length: 28%, stroke: 0.5pt + rgb("#bbbbbb")),
      v(0.7em),
      text(size: 14pt, fill: rgb("#444444"))[#course],
      v(1fr),
      text(size: 12pt)[#_fmt-authors(author)],
      v(0.3em),
      text(size: 11pt, fill: rgb("#888888"))[#date],
      v(1.8em),
      image("IMADA_en.png", width: 15em),
      v(1cm),
    )
  )
  pagebreak()
  if outline { std.outline(depth: outline-depth); pagebreak() }
  base-style(body)
}

// ── exercise ─────────────────────────────────────────
#let exercise(
  title: default-title,
  author: default-author,
  course: default-course,
  date: default-date,
  outline: true,
  outline-depth: none,
  ..args,
) = {
  let body = args.pos().at(0, default: [])
  set page(paper: "us-letter", margin: (left: 3cm, right: 3cm, top: 3cm, bottom: 3cm))
  align(center,
    stack(
      spacing: 0pt,
      v(1.2cm),
      line(length: 100%, stroke: 3pt + rgb("#b7410e")),
      v(1.2em),
      text(size: 9.5pt, fill: rgb("#b7410e"), tracking: 2.5pt, weight: "bold")[EXERCISES],
      v(2.5cm),
      text(size: 30pt, weight: "bold")[#title],
      v(1.3em),
      line(length: 28%, stroke: 0.5pt + rgb("#bbbbbb")),
      v(0.7em),
      text(size: 14pt, fill: rgb("#444444"))[#course],
      v(1fr),
      text(size: 12pt)[#_fmt-authors(author)],
      v(0.3em),
      text(size: 11pt, fill: rgb("#888888"))[#date],
      v(1.8em),
      image("IMADA_en.png", width: 15em),
      v(1cm),
    )
  )
  pagebreak()
  if outline { std.outline(depth: outline-depth); pagebreak() }
  base-style(body)
}

// ── assignment ───────────────────────────────────────
#let assignment(
  title: default-title,
  author: default-author,
  course: default-course,
  date: default-date,
  outline: true,
  outline-depth: none,
  ..args,
) = {
  let body = args.pos().at(0, default: [])
  set page(paper: "us-letter", margin: (left: 3cm, right: 3cm, top: 3cm, bottom: 3cm))
  align(center,
    stack(
      spacing: 0pt,
      v(1.2cm),
      line(length: 100%, stroke: 3pt + rgb("#b7410e")),
      v(1.2em),
      text(size: 9.5pt, fill: rgb("#621e00"), tracking: 2.5pt, weight: "bold")[ASSIGNMENTS],
      v(2.5cm),
      text(size: 30pt, weight: "bold")[#title],
      v(1.3em),
      line(length: 28%, stroke: 0.5pt + rgb("#bbbbbb")),
      v(0.7em),
      text(size: 14pt, fill: rgb("#444444"))[#course],
      v(1fr),
      text(size: 12pt)[#_fmt-authors(author)],
      v(1.8em),
      text(size: 11pt, fill: rgb("#888888"))[#date],
      v(1.8em),
      image("IMADA_en.png", width: 15em),
      v(1cm),
    )
  )
  pagebreak()
  if outline { std.outline(depth: outline-depth); pagebreak() }
  base-style(body)
}

// ── project ──────────────────────────────────────────
#let project(
  title: default-title,
  subtitle: none,
  author: default-author,
  course: default-course,
  date: default-date,
  group: none,
  supervisor: none,
  university: "University of Southern Denmark",
  abstract: none,
  keywords: none,
  outline: true,
  outline-depth: none,
  ..args,
) = {
  let body = args.pos().at(0, default: [])
  set page(paper: "us-letter", margin: (left: 3cm, right: 3cm, top: 3cm, bottom: 3cm))
  align(center,
    stack(
      spacing: 0pt,
      v(1.5cm),
      text(size: 13pt, fill: rgb("#555555"))[#university],
      v(0.6em),
      line(length: 60%, stroke: 0.5pt + rgb("#aaaaaa")),
      v(3cm),
      text(size: 28pt, weight: "bold")[#title],
      if subtitle != none {
        stack(v(1.5em), text(size: 15pt, fill: rgb("#444444"), style: "italic")[#subtitle])
      },
      v(1em),
      line(length: 40%, stroke: 0.5pt + rgb("#aaaaaa")),
      v(1.3em),
      text(size: 14pt, fill: rgb("#333333"))[#course],
      v(1fr),
      {
        let author-arr = if type(author) == str {
          ((name: author),)
        } else if type(author) == array and author.len() > 0 and type(author.at(0)) == str {
          author.map(n => (name: n))
        } else if type(author) == array {
          author
        } else { ((name: str(author)),) }

        let render-author(a) = align(center, stack(
          spacing: 0.25em,
          text(weight: "bold", size: 11pt)[#a.at("name", default: "")],
          if a.at("email", default: "") != "" {
            text(size: 8.5pt, fill: rgb("#4a90d9"))[#a.at("email", default: "")]
          },
        ))

        let per-row = 3
        let row-starts = range(0, author-arr.len(), step: per-row)
        stack(spacing: 1.5em,
          ..row-starts.map(i => {
            let row = author-arr.slice(i, calc.min(i + per-row, author-arr.len()))
            align(center,
              box(width: (100% * row.len() / per-row),
                grid(columns: (1fr,) * row.len(), column-gutter: 2em,
                  ..row.map(render-author))
              )
            )
          })
        )
      },
      v(1.5em),
      std.block(
        width: 60%,
        stroke: (top: 0.5pt + rgb("#aaaaaa"), bottom: 0.5pt + rgb("#aaaaaa")),
        inset: (top: 1em, bottom: 1em),
        align(left, stack(
          spacing: 0.5em,
          if group != none {
            grid(columns: (4cm, 1fr),
              text(fill: rgb("#777777"))[*Group:*], text()[#group])
          },
          if supervisor != none {
            grid(columns: (4cm, 1fr),
              text(fill: rgb("#777777"))[*Supervisor:*], text()[#supervisor])
          },
          grid(columns: (4cm, 1fr),
            text(fill: rgb("#777777"))[*Date:*], text()[#date]),
        ))
      ),
      if abstract != none {
        stack(
          spacing: 0pt,
          v(1.5em),
          std.block(
            width: 80%, stroke: none, inset: (top: 0em, bottom: 0em),
            align(left, stack(
              spacing: 0.5em,
              text(weight: "bold", size: 10pt, fill: rgb("#333333"))[Abstract],
              line(length: 100%, stroke: 0.4pt + rgb("#cccccc")),
              v(0.3em),
              text(size: 9.5pt, fill: rgb("#444444"))[#abstract],
            ))
          ),
        )
      },
      if keywords != none {
        stack(
          spacing: 0pt,
          v(0.8em),
          std.block(
            width: 80%, inset: 0pt,
            align(left, text(size: 9.5pt)[
              #text(weight: "bold", fill: rgb("#333333"))[Keywords: ]
              #text(fill: rgb("#555555"))[
                #if type(keywords) == array { keywords.join(", ") } else { keywords }
              ]
            ])
          ),
        )
      },
      v(1.8em),
      image("IMADA_en.png", width: 15em),
      v(1cm),
    )
  )
  pagebreak()
  if outline { std.outline(depth: outline-depth); pagebreak() }
  base-style(body)
}

// ── exam ─────────────────────────────────────────────
#let exam(
  title: default-title,
  subtitle: none,
  author: default-author,
  course: default-course,
  date: default-date,
  student-id: none,
  username: none,
  student-number: none,
  duration: none,
  allowed-aids: none,
  university: "University of Southern Denmark",
  outline: true,
  outline-depth: none,
  ..args,
) = {
  let body = args.pos().at(0, default: [])
  let author-name = if type(author) == str { author }
    else if type(author) == array and author.len() > 0 {
      if type(author.at(0)) == str { author.at(0) }
      else { author.at(0).at("name", default: "") }
    } else { "" }
  set page(
    paper: "us-letter",
    margin: (left: 3cm, right: 3cm, top: 3cm, bottom: 3cm),
    header: if username != none or student-number != none {
      set text(size: 9pt, fill: rgb("#555555"))
      grid(
        columns: (1fr, 1fr, 1fr),
        align(left)[#author-name],
        align(center)[#if username != none { username }],
        align(right)[#if student-number != none { student-number }],
      )
    },
  )
  align(center,
    stack(
      spacing: 0pt,
      v(1.5cm),
      text(size: 13pt, fill: rgb("#555555"))[#university],
      v(0.6em),
      line(length: 60%, stroke: 0.5pt + rgb("#aaaaaa")),
      v(0.5cm),
      text(size: 9.5pt, fill: rgb("#1a6b3c"), tracking: 2.5pt, weight: "bold")[EXAM],
      v(4.5cm),
      text(size: 28pt, weight: "bold")[#title],
      if subtitle != none {
        stack(v(1.5em), text(size: 15pt, fill: rgb("#444444"), style: "italic")[#subtitle])
      },
      v(1em),
      line(length: 40%, stroke: 0.5pt + rgb("#aaaaaa")),
      v(1.3em),
      text(size: 14pt, fill: rgb("#333333"))[#course],
      v(1fr),
      {
        let author-arr = if type(author) == str {
          ((name: author),)
        } else if type(author) == array and author.len() > 0 and type(author.at(0)) == str {
          author.map(n => (name: n))
        } else if type(author) == array {
          author
        } else { ((name: str(author)),) }

        let render-author(a) = align(center, stack(
          spacing: 0.25em,
          text(weight: "bold", size: 11pt)[#a.at("name", default: "")],
          if a.at("id", default: "") != "" {
            text(size: 9pt, fill: rgb("#555555"))[#a.at("id", default: "")]
          },
        ))

        let per-row = 3
        let row-starts = range(0, author-arr.len(), step: per-row)
        stack(spacing: 1.5em,
          ..row-starts.map(i => {
            let row = author-arr.slice(i, calc.min(i + per-row, author-arr.len()))
            align(center,
              box(width: (100% * row.len() / per-row),
                grid(columns: (1fr,) * row.len(), column-gutter: 2em,
                  ..row.map(render-author))
              )
            )
          })
        )
      },
      v(1.5em),
      std.block(
        width: 60%,
        stroke: (top: 0.5pt + rgb("#aaaaaa"), bottom: 0.5pt + rgb("#aaaaaa")),
        inset: (top: 1em, bottom: 1em),
        align(left, stack(
          spacing: 0.5em,
          if duration != none {
            grid(columns: (4cm, 1fr),
              text(fill: rgb("#777777"))[*Duration:*], text()[#duration])
          },
          if allowed-aids != none {
            grid(columns: (4cm, 1fr),
              text(fill: rgb("#777777"))[*Allowed aids:*], text()[#allowed-aids])
          },
          grid(columns: (4cm, 1fr),
            text(fill: rgb("#777777"))[*Date:*], text()[#date]),
        ))
      ),
      v(1.8em),
      image("IMADA_en.png", width: 15em),
      v(1cm),
    )
  )
  pagebreak()
  if outline { std.outline(depth: outline-depth); pagebreak() }
  base-style(body)
}

// ── chi — ACM CHI paper ──────────────────────────────
#let chi(
  title: default-title,
  authors: (),
  abstract: [],
  keywords: (),
  ccs: none,
  date: default-date,
  outline: false,
  ..args,
) = {
  let body = args.pos().at(0, default: [])
  set page(paper: "us-letter", margin: (x: 1.9cm, y: 2.3cm))
  set text(size: 9.5pt)

  v(0.5cm)
  align(center, text(size: 18pt, weight: "bold")[#title])
  v(1.5em)

  let authors-arr = if type(authors) == str {
    ((name: authors),)
  } else if authors.len() > 0 and type(authors.at(0)) == str {
    authors.map(n => (name: n))
  } else {
    authors
  }
  if authors-arr.len() > 0 {
    let render-author(a) = align(center, stack(
      spacing: 0.3em,
      text(weight: "bold", size: 10.5pt)[#a.at("name", default: "")],
      if a.at("institution", default: "") != "" { text(size: 9pt)[#a.at("institution", default: "")] },
      if a.at("city", default: "") != "" or "country" in a {
        text(size: 9pt)[#a.at("city", default: "")#if "country" in a [, #a.country]]
      },
      if a.at("email", default: "") != "" {
        text(size: 9pt, fill: rgb("#0055aa"))[#a.at("email", default: "")]
      },
    ))

    let n = authors-arr.len()
    let row-starts = range(0, n, step: 3)
    for i in row-starts {
      let row = authors-arr.slice(i, calc.min(i + 3, n))
      align(center,
        box(width: (100% * row.len() / 3),
          grid(columns: (1fr,) * row.len(), column-gutter: 2em,
            ..row.map(render-author))
        )
      )
      if i + 3 < n { v(1.5em) }
    }

    v(1.8em)
    align(center, text(size: 9pt, fill: rgb("#888888"))[#date])
    v(1em)
  }

  let has-meta = abstract != [] or keywords != () or ccs != none
  if has-meta {
    line(length: 100%, stroke: 0.5pt + rgb("#888888"))
    v(1em)
    columns(2, gutter: 1.5em, [
      #if abstract != [] {
        text(weight: "bold", size: 8.5pt, tracking: 0.8pt)[ABSTRACT]
        v(0.4em)
        abstract
      }
      #if ccs != none {
        v(0.8em)
        text(weight: "bold", size: 8.5pt, tracking: 0.8pt)[CCS CONCEPTS]
        v(0.4em)
        ccs
      }
      #if keywords != () {
        v(0.8em)
        text(weight: "bold", size: 8.5pt, tracking: 0.8pt)[KEYWORDS]
        v(0.4em)
        keywords.join("; ")
      }
    ])
  }

  line(length: 100%, stroke: 0.5pt + rgb("#888888"))
  v(1em)
  if outline { pagebreak(); std.outline(); pagebreak() }
  base-style(body)
}


/*
=============================================================
TEMPLATES — copy the block you need into a new file
=============================================================

── NOTE ──────────────────────────────────────────────────────
#import "../../temp.typ": *
#show: note.with(
  title:         "Lecture Notes",
  course:        "DM000 — Course Name",
  author:        "Firstname Lastname",
  date:          "date",
  outline:       true,          // set false to skip TOC
  outline-depth: 2,             // none = unlimited depth
)

= First Section
Content goes here.

── EXERCISE ──────────────────────────────────────────────────
#import "../../temp.typ": *
#show: exercise.with(
  title:         "Exercises 1",
  course:        "DM000 — Course Name",
  author:        "Firstname Lastname",
  date:          "date",
  outline:       true,
  outline-depth: 2,
)

= Exercise 1
Content goes here.

── ASSIGNMENT ────────────────────────────────────────────────
#import "../../temp.typ": *
#show: assignment.with(
  title:         "Assignment 1",
  course:        "DM000 — Course Name",
  author:        "Firstname Lastname",
  date:          "date",
  outline:       true,
  outline-depth: 2,
)

= Problem 1
Content goes here.

── EXAM ──────────────────────────────────────────────────────
#import "../../temp.typ": *
#show: exam.with(
  title:         "Written Exam",
  subtitle:      "Re-exam",                    // optional
  course:        "DM000 — Course Name",
  author:        "Firstname Lastname",
  date:          "date",
  student-id:    "id",                         // optional
  username:      "username",                   // optional — shown in page header
  student-number: "215751682",                 // optional — shown in page header
  duration:      "4 hours",                    // optional
  allowed-aids:  "All written materials",      // optional
  university:    "University",
  outline:       false,
)

= Problem 1
Content goes here.

── EXAM (group / multiple students) ─────────────────────────
#import "../../temp.typ": *
#show: exam.with(
  title:        "Written Exam",
  course:       "DM000 — Course Name",
  author: (
    (name: "Firstname Lastname", id: "id"),
    (name: "Firstname Lastname", id: "id"),
  ),
  date:         "June 2026",
  duration:     "4 hours",
  allowed-aids: "None",
)

= Problem 1
Content goes here.

── PROJECT ───────────────────────────────────────────────────
#import "../../temp.typ": *
#show: project.with(
  title:         "Project Title",
  subtitle:      "Optional subtitle",          // optional
  course:        "DM000 — Course Name",
  author:        "Firstname Lastname",         // or array of dicts below
  date:          "date",
  group:         "Group 4",                    // optional
  supervisor:    "Prof. Firstname Lastname",   // optional
  university:    "University of Southern Denmark",
  outline:       true,
  outline-depth: 2,
)

= Introduction
Content goes here.

── PROJECT (multiple authors with email) ─────────────────────
#import "../../temp.typ": *
#show: project.with(
  title:  "Project Title",
  course: "DM000 — Course Name",
  author: (
    (name: "Firstname Lastname", email: "mail@mail.com"),
    (name: "Firstname Lastname", email: "mail@mail.com"),
  ),
  date:       "date",
  group:      "Group no.",
  supervisor: "Prof. Firstname Lastname",
)

= Introduction
Content goes here.

── CHI PAPER ─────────────────────────────────────────────────
#import "../../temp.typ": *
#show: chi.with(
  title: "Paper Title",
  authors: (
    (name: "Firstname Lastname", institution: "University", city: "City", country: "County", email: "mail@mail.com"),
    (name: "Firstname Lastname", institution: "University", city: "City", country: "County", email: "mail@mail.com"),
  ),
  abstract: [Your abstract text here.],
  keywords: ("keyword one", "keyword two", "keyword three"),
  ccs:      [\u{2192} text1 \u{2192} text2], // optional
  date:     "date",
  outline:  false,
)
#set page(columns: 2)

= Introduction
Content goes here.
*/