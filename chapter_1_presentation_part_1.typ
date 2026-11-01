// ============================================================
//  Лекция. М. Рид, Б. Саймон. Методы современной матем. физики. Т. 1
//  Глава I. Предварительные сведения (≈ 60 мин)
//  Typst ≥ 0.14 · touying 0.7.4 · lilaq 0.6.0 · tiptoe 0.4.0
//  (для Typst 0.15 можно заменить на touying:0.8.0)
// ============================================================
#import "@preview/touying:0.7.4": *
#import themes.metropolis: *
#import "@preview/lilaq:0.6.0" as lq
#import "@preview/tiptoe:0.4.0"

#show: lq.set-diagram(grid: none)

#show: metropolis-theme.with(
  aspect-ratio: "16-10",
  footer: self => [Рид, Саймон · Гл. I. Предварительные сведения],
  config-info(
    title: [Предварительные сведения, часть I],
    subtitle: [М. Рид, Б. Саймон. Методы современной математической физики. Т. 1, гл. I],
    author: [Соавторы: Полянский Владислав Игоревич, Антропиков Клавдий Опусович],
    date: [30 октября 2026 г.],
    institution: [],
  ),
  // Заметки лектора на втором экране:
  // config-common(show-notes-on-second-screen: right),
  // Раздаточный вариант без пошаговых показов:
  // config-common(handout: true),
)

#set text(
  font: ("Fira Sans", "PT Sans", "Noto Sans", "DejaVu Sans"),
  size: 19pt,
  lang: "ru",
  region: "ru",
)
#show math.equation: set text(font: "New Computer Modern Math")
#set par(justify: false, leading: 0.6em)
#set list(spacing: 0.7em)
#set enum(spacing: 0.7em)

// ------------------------------------------------------------
//  Цвета и окружения
// ------------------------------------------------------------
#let navy = rgb("#23373b")
#let accent = rgb("#eb811b")
#let blue-c = rgb("#2a6f97")
#let green-c = rgb("#2e7d32")
#let red-c = rgb("#b23a48")

#let tblock(kind, color, title: none, body) = block(
  width: 100%,
  inset: (x: 0.8em, y: 0.5em),
  radius: 3pt,
  fill: color.lighten(91%),
  stroke: (left: 3pt + color),
  above: 0.55em,
  below: 0.55em,
)[#text(fill: color, weight: "bold")[#kind#if title != none [ (#title)].] #body]

#let thm(kind, title: none, body) = tblock(kind, navy, title: title, body)
#let defn(title: none, body) = tblock("Определение", blue-c, title: title, body)
#let ex(kind, title: none, body) = tblock(kind, green-c, title: title, body)
#let warn(kind: "Внимание", body) = tblock(kind, red-c, body)
#let keyidea(body) = block(
  width: 100%, inset: 0.7em, radius: 4pt,
  fill: accent.lighten(85%), stroke: 1pt + accent,
  align(center, body),
)
#let pf(title: "Доказательство", end: true, body) = block(
  width: 100%, above: 0.5em, below: 0.5em,
  inset: (left: 0.8em), stroke: (left: 1pt + luma(150)),
)[#emph(title). #body#if end [#h(1fr)$square.filled$]]

#let fig(body, cap) = align(center, stack(
  dir: ttb, spacing: 0.45em,
  { set text(size: 14pt); body },
  text(size: 13pt, fill: luma(90))[#cap],
))

#let Ran = math.op("Ran")
#let limpt = math.op("lim pt")

// ------------------------------------------------------------
//  Стили рисунков (lilaq)
// ------------------------------------------------------------


// ВАЖНО: не называть переменную `thin` — это встроенный тонкий пробел в формулах!
#let st-thin = 0.7pt + black
#let st-dashed = (paint: black, thickness: 0.8pt, dash: "dashed")
#let open-dot = circle(radius: 2.6pt, stroke: 0.9pt + black, fill: white)
#let fill-r = blue-c.lighten(60%)   // полоска Римана
#let fill-l = accent.lighten(50%)   // слои Лебега
// крупные подписи на рисунках
#let lab(body) = text(size: 15pt, body)

// рис. I.1 — метрики на окружности
#let fig-metrics = {
  let (a1, a2) = (0.26, 2.25)
  let am = (a1 + a2) / 2
  let pt(t, r: 1) = (r * calc.cos(t), r * calc.sin(t))
  let (p, q) = (pt(a1), pt(a2))
  let ts = lq.linspace(0, 2 * calc.pi, num: 241)
  let arc = lq.linspace(a1, a2, num: 80)
  lq.diagram(
    width: 6cm, height: 6cm,
    xlim: (-1.35, 1.35), ylim: (-1.35, 1.35),
    xaxis: none, yaxis: none,
    lq.plot(ts.map(calc.cos), ts.map(calc.sin), mark: none, color: black, stroke: 1.2pt),
    lq.plot(arc.map(calc.cos), arc.map(calc.sin), mark: none, color: accent, stroke: 2.4pt),
    lq.line(p, q, stroke: 1.5pt + blue-c),
    lq.place(..p, open-dot),
    lq.place(..q, open-dot),
    lq.place(..pt(a1, r: 1.17), lab($p$)),
    lq.place(..pt(a2, r: 1.17), lab($p'$)),
    lq.place(..pt(am, r: 1.19), text(fill: accent, lab($d_2$))),
    lq.place(..pt(am, r: 0.36), text(fill: blue-c, lab($d_1$))),
  )
}

// рис. I.2 — «шапочка» g_n
#let fig-gn = lq.diagram(
  width: 11cm, height: 4.5cm,
  xlim: (0, 0.85), ylim: (0, 1.2),
  xaxis: (
    ticks: (
      (0.35, lab($display(1/(2n+1))$)),
      (0.5, lab($display(1/(2n))$)),
      (0.65, lab($display(1/(2n-1))$)),
    ),
    subticks: none, mirror: false, tip: tiptoe.stealth,
  ),
  yaxis: (ticks: ((1, lab($1$)),), subticks: none, mirror: false),
  lq.plot((0, 0.35, 0.5, 0.65, 0.8), (0, 0, 1, 0, 0),
    mark: none, color: black, stroke: 1.6pt, clip: false),
  lq.place(100%, 0, align: left + horizon, pad(left: 6pt, lab($x$))),
)

// рис. I.3 — трапеция f_n
#let fig-fn = {
  let w = 0.16
  let (a, b, c, d) = (0.25 - w / 2, 0.25 + w / 2, 0.75 - w / 2, 0.75 + w / 2)
  let ya = 1.2
  let arr(p, q) = lq.line(p, q, stroke: st-thin,
    tip: tiptoe.stealth, toe: tiptoe.stealth, clip: false)
  lq.diagram(
    width: 10cm, height: 5.2cm,
    xlim: (0, 1.1), ylim: (0, 1.6),
    xaxis: (
      ticks: ((0.25, lab($display(1/4)$)), (0.75, lab($display(3/4)$))),
      subticks: none, mirror: false,
    ),
    yaxis: (ticks: ((1, lab($1$)),), subticks: none, mirror: false),
    lq.plot((0, a, b, c, d, 1.1), (0, 0, 1, 1, 0, 0),
      mark: none, color: black, stroke: 1.8pt, clip: false),
    lq.line((a, 0), (a, 1.3), stroke: st-thin),
    lq.line((d, 0), (d, 1.3), stroke: st-thin),
    lq.line((b, 0), (b, 1), stroke: st-dashed),
    lq.line((c, 0), (c, 1), stroke: st-dashed),
    arr((a, ya), (b, ya)),
    arr((c, ya), (d, ya)),
    lq.place((a + b) / 2, ya, align: bottom, pad(bottom: 6pt, lab($display(1/(4n))$))),
    lq.place((c + d) / 2, ya, align: bottom, pad(bottom: 6pt, lab($display(1/(4n))$))),
  )
}

// рис. I.4 — Риман и Лебег
#let f4(x) = 0.42 + 0.6 * x * x + 0.3 * calc.exp(-calc.pow((x - 0.28) / 0.15, 2))
#let xs4 = lq.linspace(0, 1, num: 300)
#let (xm1, xm) = (0.34, 0.48)
#let (lev-lo, lev-hi) = (0.6, 0.7)
#let leb-runs = {
  let runs = ()
  let start = none
  for x in lq.linspace(0, 1, num: 801) {
    let inside = f4(x) >= lev-lo and f4(x) < lev-hi
    if inside and start == none { start = x } else if not inside and start != none {
      runs.push((start, x))
      start = none
    }
  }
  if start != none { runs.push((start, 1.0)) }
  runs
}
#let frame4 = (
  width: 9.5cm, height: 5.4cm,
  xlim: (0, 1), ylim: (0, 1.1),
  yaxis: (ticks: none, mirror: false),
)
#let riemann-fig = lq.diagram(
  ..frame4,
  xaxis: (
    ticks: (
      (0, lab($a$)), (0.09, lab($x_1$)),
      (xm1, lab($x_(m-1)$)), (xm, lab($x_m$)), (1, lab($b$)),
    ),
    subticks: none, mirror: false,
  ),
  lq.fill-between((xm1, xm), (calc.min(f4(xm1), f4(xm)),) * 2,
    fill: fill-r, stroke: 0.8pt + blue-c),
  lq.line((xm1, 0), (xm1, f4(xm1)), stroke: st-thin),
  lq.line((xm, 0), (xm, f4(xm)), stroke: st-thin),
  lq.line((1, 0), (1, 1.1), stroke: 0.9pt + black, clip: false),
  lq.plot(xs4, f4, mark: none, color: black, stroke: 1.8pt),
)
#let lebesgue-fig = lq.diagram(
  ..frame4,
  xaxis: (ticks: ((0, lab($a$)),), subticks: none, mirror: false),
  ..leb-runs.map(((x0, x1)) => lq.fill-between((x0, x1), (lev-lo, lev-lo),
    fill: fill-l, stroke: 0.8pt + accent)),
  ..(lev-lo, lev-hi).map(y => lq.line((0, y), (1.04, y), stroke: st-dashed, clip: false)),
  lq.line((1, 0), (1, 1.1), stroke: 0.9pt + black, clip: false),
  lq.line((0.97, 0.1), (1.0, 0.1), stroke: 0.9pt + black),
  lq.plot(xs4, f4, mark: none, color: black, stroke: 1.8pt),
  lq.place(1.04, lev-hi, align: left + bottom, pad(left: 3pt, lab($display(m/n)$))),
  lq.place(1.04, lev-lo, align: left + top, pad(left: 3pt, lab($display((m-1)/n)$))),
  lq.place(1.04, 0.1, align: left + horizon, pad(left: 3pt, lab($display(1/n)$))),
)

// контрпример к мажорированной сходимости
#let fig-dct = lq.diagram(
  width: 10cm, height: 4.4cm,
  xlim: (-4.8, 4.8), ylim: (0, 1.15),
  xaxis: (
    ticks: (-4, -2, -1, 1, 2, 4).map(t => (t, lab($#t$))),
    subticks: none, mirror: false,
  ),
  yaxis: (
    ticks: ((0.25, lab($display(1/4)$)), (0.5, lab($display(1/2)$)), (1, lab($1$))),
    subticks: none, mirror: false,
  ),
  legend: (position: right + top),
  ..(1, 2, 4).map(n => lq.plot((-n, -n, n, n), (0, 1 / n, 1 / n, 0),
    mark: none, stroke: 1.8pt, label: $f_#n$)),
)

// рис. I.5 — множество Кантора
#let fig-cantor-set = {
  let removed = ((1 / 3, 2 / 3), (1 / 9, 2 / 9), (7 / 9, 8 / 9))
  let lvl3 = (1, 2, 7, 8, 19, 20, 25, 26).map(k => k / 27)
  let tick(x, h: 0.3) = lq.line((x, -h), (x, h), stroke: 0.9pt + black)
  let glyph(s) = text(size: 22pt, top-edge: "bounds", bottom-edge: "bounds", s)
  lq.diagram(
    width: 20cm, height: 2cm,
    xlim: (-0.02, 1.02), ylim: (-1, 1),
    xaxis: none, yaxis: none,
    lq.line((0, 0), (1, 0), stroke: 1.4pt + black),
    ..(0, 1).map(x => tick(x, h: 0.45)),
    tick(0.5),
    ..lvl3.map(x => tick(x)),
    ..removed.map(((a, b)) => lq.place(a, 0, glyph("("))),
    ..removed.map(((a, b)) => lq.place(b, 0, glyph(")"))),
    lq.place(0, -0.6, align: top, lab($0$)),
    lq.place(0.5, -0.6, align: top, lab($display(1/2)$)),
    lq.place(1, -0.6, align: top, lab($1$)),
  )
}

// рис. I.6 — функция Кантора: уровни 1–2 сплошные, мельче — пунктир (как в книге)
#let fig-cantor-fn = {
  let solid = ()
  let dotted = ()
  let lvl = ((0.0, 1.0, 0.0, 1.0),)
  for k in range(1, 7) {
    let nxt = ()
    for (a, b, va, vb) in lvl {
      let m1 = (2 * a + b) / 3
      let m2 = (a + 2 * b) / 3
      let vm = (va + vb) / 2
      if k <= 2 { solid.push((m1, m2, vm)) } else { dotted.push((m1, m2, vm)) }
      nxt.push((a, m1, va, vm))
      nxt.push((m2, b, vm, vb))
    }
    lvl = nxt
  }
  lq.diagram(
    width: 8.5cm, height: 5.4cm,
    xlim: (0, 1.03), ylim: (0, 1.05),
    xaxis: (
      ticks: ((0, lab($0$)), (0.5, lab($display(1/2)$)), (1, lab($1$))),
      subticks: none, mirror: false,
    ),
    yaxis: (
      ticks: (
        (0.25, lab($display(1/4)$)), (0.5, lab($display(1/2)$)),
        (0.75, lab($display(3/4)$)), (1, lab($1$)),
      ),
      subticks: none, mirror: false,
    ),
    ..solid.map(((x1, x2, y)) => lq.plot((x1, x2), (y, y),
      mark: none, color: black, stroke: 1.8pt)),
    ..dotted.map(((x1, x2, y)) => lq.plot((x1, x2), (y, y),
      mark: none, color: black,
      stroke: (thickness: 1.8pt, dash: "dotted", cap: "round"))),
  )
}

// рис. I.7 — ε/3-прием («вверх, поперек, вниз»)
#let fig-eps3 = {
  let s = 1pt + black
  let ln(p, q, ..args) = lq.line(p, q, stroke: s, clip: false, ..args)
  box(inset: (x: 4.2cm, top: 0.8cm), lq.diagram(
    width: 8cm, height: 3cm,
    xlim: (0, 1), ylim: (0, 1),
    xaxis: none, yaxis: none,
    ln((0, 0), (0, 0.58), tip: tiptoe.stealth),
    ln((0, 0.5), (0, 1)),
    ln((0, 1), (0.54, 1), tip: tiptoe.stealth),
    ln((0.5, 1), (1, 1)),
    ln((1, 1), (1, 0)),
    lq.line((0, 0), (1, 0), stroke: st-dashed, clip: false),
    lq.place(0, 0, open-dot),
    lq.place(1, 0, open-dot),
    lq.place(0, 0.5, align: right, pad(right: 8pt, lab($|f_n (x) - f(x)|$))),
    lq.place(1, 0.5, align: left, pad(left: 8pt, lab($|f_n (y) - f(y)|$))),
    lq.place(0.5, 1, align: bottom, pad(bottom: 6pt, lab($|f_n (x) - f_n (y)|$))),
  ))
}

// рис. I.8 — диагональный метод
#let rows8 = (1.0, 0.86, 0.72, 0.52)
#let frame8 = (
  width: 6cm, height: 4.4cm,
  xlim: (-0.05, 1.05), ylim: (-0.28, 1.12),
  xaxis: none, yaxis: none,
)
#let dots8(xs, ys) = lq.plot(xs, ys, stroke: none, mark: "o", mark-size: 3.5pt, color: black)
#let diag-a = lq.diagram(
  ..frame8,
  ..rows8.map(y => lq.line((0, y), (1, y), stroke: 1.2pt + black)),
  dots8((0.5,) * 3, (0.40, 0.30, 0.20)),
  lq.line((0, 0.04), (1, 0.04), stroke: 1.2pt + black),
  lq.place(0, 0.04, align: right, pad(right: 4pt, lab($f_(n_oo)$))),
  lq.place(0.5, -0.14, lab($?$)),
)
#let diag-b = {
  let x-of(y) = 0.02 + (1.1 - y) / 1.3 * 0.85
  lq.diagram(
    ..frame8,
    ..rows8.map(y => lq.line((0, y), (1, y), stroke: 1.2pt + black)),
    lq.line((x-of(1.1), 1.1), (x-of(-0.22), -0.22), stroke: 1.6pt + accent, clip: false),
    dots8((0.40, 0.30, 0.20).map(y => x-of(y) - 0.07), (0.40, 0.30, 0.20)),
  )
}

// ============================================================
//  СЛАЙДЫ
// ============================================================
#title-slide()

== План лекции

#grid(
  columns: (1.3fr, 1fr),
  gutter: 1.5em,
  align: (left + horizon, right + horizon),
  table(
    columns: (auto, 1fr, auto),
    stroke: none,
    inset: (x: 0.5em, y: 0.32em),
    table.hline(stroke: 0.8pt),
    [*§*], [*Тема*], [*мин*],
    table.hline(stroke: 0.4pt),
    [I.1], [Множества и функции], [15],
    [I.2], [Метрические и нормированные пространства], [45],
    table.hline(stroke: 0.8pt),
  ),
  block(width: 100%, inset: (left: 1em), stroke: (left: 2pt + accent))[
    #set text(size: 16pt)
    _Начинающий… не должен смущаться, если… он обнаружит, что у него не хватает
    предварительных знаний даже для чтения предварительных сведений._
    #align(right)[— П. Халмош]
  ],
)

#speaker-note[
  Эпиграф — повод сказать: глава — словарь, а не учебник; многое дается без доказательств.
]

// ============================================================
= I.1. Множества и функции

== Обозначения

#grid(
  columns: (1fr, 1fr),
  gutter: 2em,
  [
    *Множества*
    - $x in X$, #h(0.3em) $x in.not X$; #h(0.3em) $(forall x in X)$, $(exists x in X)$
    - ${x | P(x)}$ — множество $x$ со свойством $P$
    - $A without B = {x in X | x in A, x in.not B}$
    - $overline(A)$ — замыкание (в топологическом пространстве)
    - $X times Y = {chevron.l x, y chevron.r | x in X, y in Y}$
  ],
  [
    *Функции* («функция» = «отображение»)
    - $f: X -> Y$, #h(0.3em) $x |-> f(x)$ — всегда однозначны
    - $f[A] = {f(x) | x in A}$, #h(0.3em) $f^(-1)[B] = {x | f(x) in B}$
    - $Ran f = f[X]$ — область значений
    - $f | A$ — сужение на $A$
    - $f(dot.c, y)$ — функция первой переменной при фикс. $y$
    - линейная функция = _оператор_
  ],
)

#speaker-note[Около 1 мин. Ссылаться на слайд как на справку.]

== Инъекции, сюръекции, характеристические функции

- *инъективна* (взаимно однозначна): каждое $y in Ran f$ имеет не более одного прообраза;
- *сюръективна* («на»): $Ran f = Y$;
- *биекция*: инъективна и сюръективна.

#pause

Характеристическая функция множества $A subset X$:
$ chi_A (x) = cases(1 quad & "если " x in A",", 0 & "если " x in.not A".") $

#pause

*Отношение* на $X$ — любое подмножество $R subset X times X$;
пишут $x R y$, если $chevron.l x, y chevron.r in R$.

== Отношение эквивалентности

#defn[
  $R$ — отношение эквивалентности, если
  (i) $x R x$ (рефлексивность);
  (ii) $x R y => y R x$ (симметричность);
  (iii) $x R y, y R z => x R z$ (транзитивность).
]

#thm("Теорема I.1")[
  Каждый $x in X$ принадлежит единственному классу эквивалентности $[x]$.
  Значит, $R$ разбивает $X$ на непересекающиеся классы.
]

#pause

#grid(
  columns: (1fr, 1fr),
  gutter: 1em,
  ex("Пример", title: [$ZZ$ mod 3])[
    $x R y <=> 3 | (x - y)$:
    $[0] = {..., -3, 0, 3, ...}$,
    $[1] = {..., -2, 1, 4, ...}$,
    $[2] = {..., -1, 2, 5, ...}$.
  ],
  ex("Пример", title: [проективная прямая])[
    $X = RR^2 without {0}$, $x R y <=> x = alpha y$.
    Классы — прямые через начало без точки $chevron.l 0, 0 chevron.r$.
  ],
)

== Частичный порядок

#defn[
  *Частичное упорядочение* $x < y$: рефлексивно, транзитивно и *антисимметрично*
  ($x < y$ и $y < x$ $=>$ $x = y$).
]

- «Частичное» — элементы могут быть _несравнимы_.
  Пример: подмножества $Y$, упорядоченные включением $A subset B$.
- *Линейный порядок*: для любых $x, y$ либо $x < y$, либо $y < x$ (например, $(RR, <=)$).

#pause

Пусть $Y subset X$:
- $p in X$ — *верхняя грань* $Y$, если $y < p$ для всех $y in Y$;
- $m$ — *максимальный элемент* $X$, если $m < x => x = m$.

== Лемма Цорна

#thm("Теорема I.2", title: [лемма Цорна])[
  Пусть $X$ — непустое частично упорядоченное множество, в котором каждое линейно
  упорядоченное подмножество имеет верхнюю грань. Тогда каждое линейно упорядоченное
  подмножество имеет верхнюю грань, являющуюся максимальным элементом $X$.
]

- Эквивалентна *аксиоме выбора*.
- Рид и Саймон принимают ее _как аксиому_ теории множеств.
- Конец доказательства обозначается символом Халмоша $square.filled$.

#speaker-note[
  Применения будут позже (например, теорема Хана—Банаха, гл. III). Отметить это вслух.
]

// ============================================================
= I.2. Метрические и нормированные пространства

== Метрическое пространство

#defn[
  *Метрическое пространство* — пара $chevron.l M, d chevron.r$, где
  $d: M times M -> RR$ и
  #grid(
    columns: (1fr, 1fr),
    row-gutter: 0.5em,
    [(i) $d(x, y) >= 0$;],
    [(ii) $d(x, y) = 0 <=> x = y$;],
    [(iii) $d(x, y) = d(y, x)$;],
    [(iv) $d(x, z) <= d(x, y) + d(y, z)$.],
  )
]

- Элементы называют *точками*.
- Одно и то же множество можно превратить в _разные_ метрические пространства,
  если задать разные метрики.

#pause

#ex("Пример 1")[
  $RR^n$: #h(0.3em) $d(x, y) = sqrt((x_1 - y_1)^2 + dots.h.c + (x_n - y_n)^2)$.
]

== Пример 2: две метрики на окружности

#grid(
  columns: (1.3fr, 1fr),
  gutter: 1.5em,
  align: horizon,
  [
    $M = {chevron.l alpha, beta chevron.r | alpha^2 + beta^2 = 1}$.

    - $d_1$ — длина хорды:
      $ d_1 (p, p') = sqrt((alpha - alpha')^2 + (beta - beta')^2) $
    - $d_2$ — длина меньшей дуги.

    #pause

    $ d_1 <= d_2 <= pi d_1 $
    $==>$ *одинаковая сходимость*:
    $p_n limits(->)^(d_1) p <=> p_n limits(->)^(d_2) p$.
  ],
  fig(fig-metrics)[Рис. I.1. Метрики $d_1$ и $d_2$],
)

== Пример 3: $C[0, 1]$ с двумя метриками

$ d_1 (f, g) = max_(x in [0, 1]) |f(x) - g(x)|, quad
  d_2 (f, g) = integral_0^1 |f(x) - g(x)| dif x . $

#grid(
  columns: (1fr, 1fr),
  gutter: 1em,
  align: horizon,
  [
    - $d_2 <= d_1$: сходимость по $d_1$ $=>$ по $d_2$.
    - Обратное *неверно*: «шапочки» $g_n$:
      $ d_2 (g_n, 0) = 1/(4n^2 - 1) -> 0, $
      но $d_1 (g_n, g_m) = 1$ при $n != m$.
  ],
//   fig(fig-gn)[Рис. I.2. График $g_n (x)$],
  fig(image("figures/Screenshot 2026-10-30 at 15.21.33.png"))[Рис. I.2. График $g_n (x)$],
)

#keyidea[Разные метрики на одном множестве дают *разные* понятия сходимости.]

== Сходимость и последовательности Коши

#defn[
  $x_n -> x$ в $chevron.l M, d chevron.r$, если $d(x_n, x) -> 0$.
  Если сходимости нет, пишут $x_n limits(arrow.r.not)^d x$.
]

#defn(title: [последовательность Коши])[
  $(forall epsilon > 0)(exists N)$: $n, m >= N => d(x_n, x_m) < epsilon$.
]

#pause

#thm("Предложение")[Любая сходящаяся последовательность — последовательность Коши.]

#pf[
  $d(x_n, x_m) <= d(x_n, x) + d(x, x_m) < epsilon/2 + epsilon/2 = epsilon$ при $n, m >= N$.
]

Так как $d_1 (g_n, g_m) = 1$, последовательность $g_n$ не является последовательностью Коши в
$chevron.l C, d_1 chevron.r$, а значит, не сходится в нем.

== Полнота

#defn[Пространство *полно*, если в нем сходится любая последовательность Коши.]

#grid(
  columns: (1fr, 1fr),
  gutter: 1.5em,
  [
    *Обратное к предложению неверно:*
    $x_n in QQ$, $x_n -> x^* in RR without QQ$.

    Последовательность $(x_n)$ — Коши в $QQ$, но предела в $QQ$ нет.
  ],
  [
    #table(
      columns: 2, stroke: none, inset: 0.35em,
      [$RR$], text(fill: green-c)[полно],
      [$QQ$], text(fill: red-c)[неполно],
      [$chevron.l C[0, 1], d_1 chevron.r$], text(fill: green-c)[полно (§ I.5)],
      [$chevron.l C[0, 1], d_2 chevron.r$], text(fill: red-c)[неполно (§ I.3)],
    )
  ],
)

#pause

#defn(title: [плотность])[
  $B subset M$ *плотно* в $M$, если каждый $m in M$ — предел последовательности из $B$.
]

Как сделать пространство полным? _Добавить «все пределы последовательностей Коши»._

== Непрерывность и изометрии

#defn[
  $f: chevron.l X, d chevron.r -> chevron.l Y, rho chevron.r$ *непрерывна* в $x$, если
  $x_n limits(->)^d x => f(x_n) limits(->)^rho f(x)$.
]

#ex("Пример")[
  Тождественное отображение $chevron.l C, d_1 chevron.r -> chevron.l C, d_2 chevron.r$
  непрерывно, а $chevron.l C, d_2 chevron.r -> chevron.l C, d_1 chevron.r$ — *нет*.
]

#pause

#defn(title: [изометрия])[
  Биекция $h: X -> Y$ с условием $rho(h(x), h(y)) = d(x, y)$.
]

Изометричные пространства неразличимы по метрическим свойствам.

== Пополнение

#thm("Теорема I.3")[
  Для любого неполного $chevron.l M, d chevron.r$ существует полное метрическое
  пространство $overline(M)$, в котором $M$ изометрично плотному подмножеству.
]

*Набросок доказательства:*

+ ${x_n} tilde {y_n}$, если $d(x_n, y_n) -> 0$ (для последовательностей Коши).
  #pause
+ $overline(M)$ — множество классов эквивалентности последовательностей Коши.
  #pause
+ Метрика: $overline(d)([{x_n}], [{y_n}]) = lim d(x_n, y_n)$; предел существует и не зависит от представителей.
  #pause
+ Вложение $h: x |-> [{x, x, x, ...}]$ — изометрия на плотное подмножество.

#speaker-note[Пример: $RR$ — пополнение $QQ$ (конструкция Кантора).]

== Открытые и замкнутые множества

#set text(size: 17.5pt)
#defn[
  Пусть $chevron.l X, d chevron.r$ — метрическое пространство.
  #grid(
    columns: (1fr, 1fr),
    column-gutter: 1.2em,
    row-gutter: 0.6em,
    [(a) *шар* $B(y; r) = {x | d(x, y) < r}$;],
    [(b) $O$ *открыто*: $(forall y in O)(exists r > 0)$ $B(y; r) subset O$;],
    [(c) $N$ — *окрестность* $y$: $B(y; r) subset N$ при некотором $r$;],
    [(d) $x$ — *предельная точка* $E$: $(forall r)$ $B(x; r) inter (E without {x}) != emptyset$;],
    [(e) $F$ *замкнуто*, если содержит все свои предельные точки;],
    [(f) $x$ — *внутренняя точка* $G$, если $G$ — окрестность $x$.],
  )
]

== Свойства (теоремы I.4, I.5)

#thm("Теорема I.4")[
  (a) $O$ открыто $<=>$ $X without O$ замкнуто.
  (b) $x_n -> x$ $<=>$ для любой окрестности $N$ точки $x$ почти все $x_m in N$.
  (c) Множество внутренних точек открыто.
  (d) $E union {"предельные точки"}$ замкнуто.
  (e) $O$ открыто $<=>$ оно окрестность каждой своей точки.
]

#thm("Теорема I.5")[
  $f: X -> Y$ непрерывна $<=>$ $f^(-1)[O]$ открыто для каждого открытого $O subset Y$.
]

#warn[
  В неполном пространстве замкнутость обманчива: $[1/2, 1)$ *замкнуто* в $(0, 1)$.
]

== Нормированные линейные пространства

#defn[
  Векторное пространство $V$ над $RR$ ($CC$) с нормой $norm(dot.c): V -> RR$:
  #grid(
    columns: (1fr, 1fr),
    row-gutter: 0.5em,
    [(i) $norm(v) >= 0$;],
    [(ii) $norm(v) = 0 <=> v = 0$;],
    [(iii) $norm(alpha v) = |alpha| norm(v)$;],
    [(iv) $norm(v + w) <= norm(v) + norm(w)$.],
  )
]

- Норма задает метрику: $d(v, w) = norm(v - w)$.
- Примеры: $RR^n$ с $norm(x) = sqrt(|x_1|^2 + dots.h.c + |x_n|^2)$;
  $C[0, 1]$ с
  $ norm(f)_oo = sup_(x) |f(x)| quad "или" quad norm(f)_1 = integral_0^1 |f(x)| dif x. $
- *Полнота* понимается в метрике, порожденной нормой.

== Ограниченные операторы

#defn[
  $T: V_1 -> V_2$ — *ограниченный оператор*, если
  (i) $T(alpha v + beta w) = alpha T v + beta T w$;
  (ii) $norm(T v)_2 <= C norm(v)_1$ для всех $v$.

  *Норма оператора:* #h(0.5em) $display(norm(T) = sup_(norm(v)_1 = 1) norm(T v)_2)$
  #h(0.3em) — наименьшее такое $C$.
]

#pause

#thm("Теорема I.6")[
  Для линейного $T$ между нормированными пространствами эквивалентно:
  (a) $T$ непрерывно в одной точке;
  (b) $T$ непрерывно всюду;
  (c) $T$ ограничено.
]

#keyidea[Для линейных отображений: *непрерывность = ограниченность*.]

== Теорема об ограниченном продолжении (BLT)

#thm("Теорема I.7", title: [об ограниченном линейном отображении])[
  Пусть $T: V_1 -> V_2$ ограничен, а $V_2$ *полно*. Тогда $T$ единственным образом
  продолжается до ограниченного оператора $overline(T): overline(V_1) -> V_2$
  с той же нормой.
]

#v(0.5em)
#keyidea[
  #text(size: 22pt)[*Главный принцип функционального анализа:*] \
  определи объект на *плотном* подмножестве $->$ продолжи по непрерывности.
]

#speaker-note[
  Ключевой слайд главы. Стоит задержаться. Дальше этот принцип даст интеграл Римана.
]

== Доказательство теоремы I.7

+ Для $x in overline(V_1)$ возьмем $x_n in V_1$, $x_n -> x$; $(x_n)$ — последовательность Коши.
  #pause
+ $norm(T x_n - T x_m)_2 <= norm(T) norm(x_n - x_m)_1$, значит, $(T x_n)$ — последовательность Коши в $V_2$.
  #pause
+ $V_2$ полно $=>$ $T x_n -> y$. Положим $overline(T) x := y$.
  #pause
+ *Корректность:* если $x_n -> x$ и $x'_n -> x$, то
  $x_1, x'_1, x_2, x'_2, ... -> x$, и предел образов один и тот же.
  #pause
+ *Ограниченность:*
  $norm(overline(T) x)_2 = lim norm(T x_n)_2 <= C lim norm(x_n)_1 = C norm(x)_1$.

Линейность и единственность — упражнение.

== Интеграл Римана через BLT (1)

- $P C[a, b]$ — ограниченные, непрерывные справа, кусочно-непрерывные функции с нормой
  $norm(f)_oo = sup |f(x)|$.
- Ступенчатые функции $S[a, b]$: $s = sum_(i=1)^n s_i chi_i$,
  где $chi_i$ — индикатор $[x_(i-1), x_i)$ (последний — индикатор $[x_(n-1), x_n]$).
  $ norm(s)_oo = max_i |s_i|. $
- $S[a, b]$ *плотно* в $P C[a, b]$ (задача 10).

== Интеграл Римана через BLT (2)

Определяем интеграл на ступенчатых функциях «как площадь»:
$ I(sum_(i=1)^n s_i chi_i) = sum_(i=1)^n s_i (x_i - x_(i-1)). $

#pause

Оценка:
$ |I(s)| <= max_i |s_i| sum_i (x_i - x_(i-1)) = (b - a) norm(s)_oo $
$==>$ $I$ — ограниченный функционал $S[a, b] -> RR$.

#pause

$RR$ полно $=>$ по теореме I.7 $I$ продолжается на $overline(S) supset P C[a, b]$.
Это и есть $display(integral_a^b f dif x)$.

Тем же способом определяется интеграл функций со значениями в любом *полном* нормированном пространстве.

== Дополнение: верхний и нижний пределы

#defn[
  Для бесконечного ограниченного $A subset RR$:
  $ overline(lim) A = sup limpt(A), quad underline(lim) A = inf limpt(A). $
]

- По теореме Больцано—Вейерштрасса $limpt(A) != emptyset$; кроме того, $overline(lim) A in limpt(A)$.
- Если $b = overline(lim) A$, то $A inter {a > b + epsilon}$ *конечно*,
  а $A inter {a > b - epsilon}$ *бесконечно*.

#thm("Свойства")[
  (a) $overline(lim)(a_n + b_n) <= overline(lim) a_n + overline(lim) b_n$;
  (b) $overline(lim) a_n b_n <= (overline(lim) a_n)(overline(lim) b_n)$ при $a_n, b_n >= 0$;
  (c) $overline(lim)(c a_n) = c overline(lim) a_n$ при $c > 0$;
  (d) $overline(lim)(c a_n) = c underline(lim) a_n$ при $c < 0$.
]


// ============================================================
= Итоги

== Главное из главы I, часть 1

+ *Метрика* $->$ сходимость $->$ последовательности Коши $->$ полнота $->$ *пополнение*.
+ *Принцип BLT:* определи на плотном множестве, продолжи по непрерывности (интеграл Римана).
== Литература (замечания к главе)

#focus-slide[
  Вопросы? 
]