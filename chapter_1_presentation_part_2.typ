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
    title: [Предварительные сведения],
    subtitle: [М. Рид, Б. Саймон. Методы современной математической физики. Т. 1, гл. I],
    author: [Соавторы: ???, Антропиков Клавдий Опусович],
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
    [I.3], [Интеграл Лебега], [??],
    [I.4], [Абстрактная теория меры], [??],
    [], [Итоги, вопросы], [2],
    table.hline(stroke: 0.8pt),
  ),
  block(width: 100%, inset: (left: 1em), stroke: (left: 2pt + accent))[
    #set text(size: 16pt)
    {{ Цитата, которая тебе нравится }}
    #align(right)[— {{ от твоего любимого военного преступника }}]
  ],
)

#speaker-note[
  Эпиграф — повод сказать: глава — словарь, а не учебник; многое дается без доказательств.
]


= I.3. Интеграл Лебега

== Почему $C[0, 1]$ неполно по $norm(dot.c)_1$

#grid(
  columns: (1.1fr, 1fr),
  gutter: 1.2em,
  align: horizon,
//   fig(fig-fn)[Рис. I.3. График $f_n$],
  fig(image("figures/Screenshot 2026-10-30 at 19.18.59.png"))[Рис. I.3. График $f_n$],
  [
    - $(f_n)$ — последовательность Коши по $norm(dot.c)_1$;
    - «сходится» к $chi_([1/4, 3/4))$ $in.not C[0, 1]$.

    #pause

    *План:*
    + построить пространство $L^1 supset C$;
    + доказать, что $L^1$ полно;
    + показать, что $overline(C) = L^1$.
  ],
)

#speaker-note[
  Пополнение через классы последовательностей Коши существует, но оно «непрозрачно».
  Хочется, чтобы элементами были функции.
]

== Идея Лебега: делить область _значений_

#fig(
//   grid(columns: 2, column-gutter: 1.6cm, riemann-fig, lebesgue-fig),
  grid(columns: 2, column-gutter: 1.6cm, image("figures/Screenshot 2026-10-30 at 19.25.19.png"), image("figures/Screenshot 2026-10-30 at 19.25.22.png")),
)[Рис. I.4. Интеграл Римана (слева) и интеграл Лебега (справа)]

Для $f >= 0$:
$ Sigma_n (f) = sum_(m=0)^oo m/n thin mu(f^(-1)[[m/n, (m+1)/n)]), quad
  integral f dif x := lim_(k -> oo) Sigma_(2^k)(f) = sup_k Sigma_(2^k)(f). $

Нужна функция «размера» $mu$, обобщающая $mu([a, b]) = b - a$.

== Какие множества можно измерить?

#warn(kind: "Парадокс Банаха—Тарского")[
  Единичный шар в $RR^3$ можно разрезать на конечное число кусков и сложить из них
  (вращениями и сдвигами) *два* единичных шара. Значит, «размер» есть не у всех множеств.
]

Требования к семейству $cal(B)$ измеримых множеств:
- замкнутость относительно дополнений;
- содержит открытые множества (чтобы $f^(-1)$ от интервала был измерим для непрерывной $f$);
- замкнутость относительно счетных объединений: $mu(union.big A_n) = sum mu(A_n)$.

#pause

#defn(title: [борелевы множества])[
  Наименьшее семейство подмножеств $RR$, замкнутое относительно дополнений и счетных
  объединений и содержащее все открытые интервалы. Оно равно пересечению всех таких семейств.
]

== Мера Лебега

#defn[
  Для открытого $I = union.big_i (a_i, b_i)$ (непересекающиеся интервалы):
  $mu(I) = sum_i (b_i - a_i)$. Для $B in cal(B)$:
  $ mu(B) = inf_(I "открыто", thin B subset I) mu(I). $
]

#thm("Теорема I.8")[
  (a) $mu(emptyset) = 0$;
  (b) $sigma$-аддитивность: $mu(union.big A_n) = sum mu(A_n)$ для попарно
  непересекающихся $A_n$;
  (c) $mu(B) = inf {mu(I) | B subset I, I "открыто"}$;
  (d) $mu(B) = sup {mu(C) | C subset B, C "компактно"}$.
]

(c), (d) — *регулярность*: приближение снаружи открытыми, изнутри компактными множествами.

== Борелевы функции и интеграл

#defn[$f$ *борелева*, если $f^(-1)[[a, b]] in cal(B)$ для всех $a, b$.]

- Эквивалентно: $f^(-1)[B] in cal(B)$ для всех $B in cal(B)$ $=>$ композиция борелевых функций борелева.
- Борелевы функции замкнуты относительно $f + g$, $f g$, $max$, $min$, $lambda f$ и
  *поточечных пределов*.
- У Рида и Саймона «борелев» = «измеримый».

#pause

Если $integral |f| dif x < oo$, пишут $f in cal(L)^1$ и полагают
$ integral f dif x = integral f_+ dif x - integral f_- dif x, quad
  f_(plus.minus) = max{plus.minus f, 0}. $

== Свойства интеграла (теорема I.9)

#thm("Теорема I.9")[
  Для измеримых $f, g$:
  #grid(
    columns: (1fr, 1fr),
    column-gutter: 1em,
    row-gutter: 0.6em,
    [(a) $f, g in cal(L)^1 => f + g, lambda f in cal(L)^1$;],
    [(b) $|g| <= f in cal(L)^1 => g in cal(L)^1$;],
    [(c) $integral (f + g) = integral f + integral g$;],
    [(d) $|integral f| <= integral |f|$;],
    [(e) $f <= g => integral f <= integral g$;],
    [(f) $|integral_a^b f| <= |b - a| sup_([a, b]) |f|$.],
  )
]

#keyidea[Все хорошие свойства интеграла Римана сохраняются, а класс функций шире.]

== Предельные теоремы

#thm("Теорема I.10", title: [о монотонной сходимости])[
  $0 <= f_n arrow.t f$, $integral f_n < C$ $=>$ $f in cal(L)^1$ и $integral |f - f_n| -> 0$.
]

#thm("Теорема I.11", title: [о мажорированной сходимости])[
  $f_n -> f$ поточечно, $|f_n| <= G in cal(L)^1$ $=>$ $f in cal(L)^1$ и $integral |f - f_n| -> 0$.
]

#grid(
  columns: (1fr, 1fr),
  gutter: 1em,
  align: horizon,
  [
    *Мажоранта важна:*
    $f_n = 1/n chi_((-n, n)) -> 0$ поточечно, но $integral f_n = 2$.
    Здесь $sup_n f_n tilde 1/|x| in.not cal(L)^1$.
  ],
  fig(fig-dct)[$f_n = 1/n chi_((-n, n))$],
)

== «Почти всюду» и пространство $L^1$

Проблема: из $integral |f - g| = 0$ не следует $f = g$.

#defn[
  Свойство выполнено *почти всюду* (п. в.), если множество, где оно ложно, содержится в
  множестве меры нуль. $f tilde g$, если $f = g$ п. в.
]

#defn[
  $L^1$ — классы эквивалентности в $cal(L)^1$ с нормой $norm(f)_1 = integral |f| dif x$.
]

#warn[
  Для $f in L^1$ значение $f(x)$ в точке *не определено*. Исключение — если у класса есть
  непрерывный представитель (он единственный).
]

Теоремы о сходимости переносятся на $L^1$ с заменой «всюду» на «п. в.».

== Теорема Рисса—Фишера

#thm("Теорема I.12", title: [Рисс—Фишер])[$L^1$ полно.]

#set text(size: 17.5pt)
#pf[
  Достаточно найти сходящуюся подпоследовательность. Выберем
  $norm(f_n - f_(n+1))_1 <= 2^(-n)$.
  #pause
  Пусть $g_m = sum_(n=1)^m |f_n - f_(n+1)| arrow.t g_oo$, причем $integral g_m <= 1$;
  по I.10 $g_oo in L^1$, поэтому $g_oo < oo$ п. в.
  #pause
  Тогда $f_m = f_1 - sum_(n < m) (f_n - f_(n+1))$ сходится п. в. к некоторой $f$, а
  $|f_m| <= |f_1| + g_oo in L^1$. По I.11 $f_m -> f$ в $L^1$.
]

#pause

- *Следствие:* если $f_n -> f$ в $L^1$, то подпоследовательность сходится к $f$ п. в.
- *Предложение:* $C[a, b]$ плотно в $L^1 [a, b]$, т. е. $L^1 = overline(C)$.

// ============================================================
= I.4. Абстрактная теория меры

== Меры Лебега—Стилтьеса

Пусть $alpha$ — неубывающая функция, $alpha(x plus.minus 0)$ — ее односторонние пределы.
$ mu_alpha ((a, b)) = alpha(b - 0) - alpha(a + 0), quad
  mu_alpha ([a, b]) = alpha(b + 0) - alpha(a - 0). $

- $mu_alpha$ продолжается на $cal(B)$ и $sigma$-аддитивна.
- *Регулярность*:
  $mu_alpha (B) = sup_(C subset B "компакт") mu_alpha (C) = inf_(O supset B "откр.") mu_alpha (O)$.
- $mu_alpha (C) < oo$ для компактов: это *борелева мера*.
- Интеграл $integral f dif alpha$ обладает свойствами I.9; $L^1 (RR, dif alpha)$ полно.
- $L^1 ([a, b], dif alpha)$ — пополнение $C[a, b]$ по метрике $integral |f - g| dif alpha$.

== Три модельных примера

#grid(
  columns: (1fr, 1fr, 1fr),
  gutter: 0.8em,
  ex("1. Гладкая", title: none)[
    $alpha in C^1$:
    $ integral f dif alpha = integral f alpha' dif x. $
    Сводится к мере Лебега.
  ],
  ex("2. Дирака", title: none)[
    $alpha = chi_([0, oo))$:
    $ integral f dif alpha = f(0). $
    $rho(f, g) = |f(0) - g(0)|$, поэтому $L^1$ *одномерно*!
  ],
  ex("3. Кантора", title: none)[
    $alpha$ непрерывна, непостоянна, но $alpha' = 0$ п. в.
    $mu_alpha$ «живет» на множестве меры Лебега 0.
  ],
)

#keyidea[Эти три примера — модели *всех* типов борелевых мер на $RR$.]

== Канторово множество и функция Кантора

#fig(fig-cantor-set)[Рис. I.5. Множество Кантора]

#grid(
  columns: (1fr, 1.1fr),
  gutter: 1em,
  align: horizon,
  fig(fig-cantor-fn)[Рис. I.6. Функция Кантора],
  [
    #set text(size: 17pt)
    - $S = (1/3, 2/3) union (1/9, 2/9) union (7/9, 8/9) union dots$, #h(0.2em) $mu(S) = 1$.
    - $C = [0, 1] without S$: троичные дроби без цифры 1. Множество *несчетно*, $mu(C) = 0$.
    - $alpha = 1/2$ на $(1/3, 2/3)$, $1/4$ и $3/4$ на следующих интервалах и т. д.
    - $mu_alpha ({p}) = 0$, но $mu_alpha (S) = 0$: мера сосредоточена на $C$.
  ],
)

== Разложение мер на $RR$

- $P = {x | mu({x}) != 0}$ — *чистые точки*; их счетное число.
- $mu_"pp" (X) = mu(P inter X)$, #h(0.3em) $mu_"cont" = mu - mu_"pp"$.

#thm("Теорема I.13")[$mu = mu_"pp" + mu_"cont"$ единственным образом.]

#pause

#defn[
  $mu$ *абсолютно непрерывна* (отн. $dif x$), если $dif mu = f dif x$ при $f in L^1_"loc"$;
  $mu$ *сингулярна*, если $mu(S) = 0$ для некоторого $S$, дополнение которого имеет лебегову меру 0.
]

#thm("Теорема I.14", title: [Лебег])[$mu = mu_"ac" + mu_"sing"$ единственным образом.]

== Каноническое разложение и квантовая механика

$ mu = underbrace(mu_"pp", "чисто точечная") + underbrace(mu_"ac", "абс. непрерывная")
  + underbrace(mu_"sing", "непрерывная сингулярная") $

#v(0.5em)

#table(
  columns: (auto, 1fr),
  stroke: none,
  inset: 0.5em,
  table.hline(stroke: 0.8pt),
  [*Компонента меры*], [*Состояния в квантовой механике*],
  table.hline(stroke: 0.4pt),
  [$mu_"pp"$], [связанные состояния],
  [$mu_"ac"$], [состояния рассеяния],
  [$mu_"sing"$], [нет физической интерпретации; для важных моделей $mu_"sing" = 0$ (гл. XIII)],
  table.hline(stroke: 0.8pt),
)

#speaker-note[Мостик к спектральной теории (гл. VII) — это мотивирует всю главу.]

== Абстрактные пространства с мерой

#defn[
  $cal(A) subset 2^M$ — *$sigma$-кольцо*, если оно замкнуто относительно счетных
  объединений и разностей $A without B$. Если $M in cal(A)$, то это *$sigma$-поле*.
]

#defn[
  *Мера* $mu: cal(A) -> [0, oo]$: $mu(emptyset) = 0$,
  $mu(union.big A_i) = sum mu(A_i)$ для попарно непересекающихся $A_i$.
]

- Тройка $chevron.l M, cal(A), mu chevron.r$; предполагается *$sigma$-конечность*:
  $M = union.big A_i$, $mu(A_i) < oo$.
- $T: M -> N$ *измеримо*, если $T^(-1)[A] in cal(A)$ для всех $A in cal(F)$.
- Строятся $integral f dif mu$, $cal(L)^1 (M, dif mu)$ и $L^1 (M, dif mu)$.

== Предельные теоремы в общем случае

#set text(size: 17.5pt)
#thm("Теорема I.15", title: [монотонная сходимость])[
  $0 <= f_1 <= f_2 <= dots$, $f = lim f_n$: $f in cal(L)^1 <=> lim norm(f_n)_1 < oo$; тогда
  $norm(f - f_n)_1 -> 0$.
]

#thm("Теорема I.16", title: [мажорированная сходимость])[
  $f_n -> f$ п. в., $|f_n| <= G in L^1$ $=>$ $f in L^1$, $norm(f - f_n)_1 -> 0$.
]

#thm("Теорема I.17", title: [лемма Фату])[
  $f_n >= 0$, $underline(lim) norm(f_n)_1 < oo$ $=>$
  $f = underline(lim) f_n in cal(L)^1$ и $norm(f)_1 <= underline(lim) norm(f_n)_1$.
]

#thm("Теорема I.18", title: [Рисс—Фишер])[$L^1 (M, dif mu)$ полно.]

Лемма Фату ничего не говорит о $norm(f - f_n)_1$.

== Абсолютная непрерывность и сингулярность

#defn[
  $mu perp nu$ (*взаимно сингулярны*), если $exists A$: $mu(A) = 0$, $nu(M without A) = 0$. \
  $nu << mu$ (*абсолютно непрерывна*), если $mu(A) = 0 => nu(A) = 0$.
]

#thm("Теорема I.19", title: [Радон—Никодим])[
  $nu << mu$ $<=>$ существует измеримая $f$, для которой
  $display(nu(A) = integral_A f dif mu)$ для всех $A$. Функция $f$ единственна $mu$-п. в.
]

#thm("Теорема I.20", title: [Лебег о разложении])[
  $nu = nu_"ac" + nu_"sing"$ единственным образом, где $nu_"ac" << mu$, $nu_"sing" perp mu$.
]

== Теорема Фубини

$cal(A) times.o cal(F)$ — наименьшее $sigma$-поле, содержащее прямоугольники $R times S$.

#thm("Теорема I.21", title: [Фубини])[
  Пусть $f$ измерима на $M times N$. Тогда
  $integral_M (integral_N |f| dif nu) dif mu < oo$ $<=>$
  $integral_N (integral_M |f| dif mu) dif nu < oo$, и в этом случае
  $ integral_N (integral_M f dif mu) dif nu = integral_M (integral_N f dif nu) dif mu. $
]

Аналог перестановки членов абсолютно сходящегося ряда. Конечность интеграла от $|f|$
*существенна* (задача 25).

== Мера-произведение

#thm("Теорема I.22")[
  Для $sigma$-конечных $mu$, $nu$ существует единственная $mu times.o nu$ с
  $(mu times.o nu)(R times S) = mu(R) nu(S)$ (где $0 dot oo = 0$), и
  $ integral_(M times N) f dif (mu times.o nu) = integral_M (integral_N f dif nu) dif mu, $
  если интеграл от $|f|$ конечен.
]

Явная формула:
$ (mu times.o nu)(E) = inf {sum_i mu(R_i) nu(S_i) mid(|) E subset.eq union.big_i R_i times S_i}. $


// ============================================================
= Итоги

== Главное из главы I, часть II
+ *Лебег:* делим значения, а не область определения; $L^1$ полно, $L^1 = overline(C[a, b])$.
+ *Мера на $RR$:* $mu = mu_"pp" + mu_"ac" + mu_"sing"$, что отвечает частям спектра в КМ.
+ *Абстрактная мера:* монотонная и мажорированная сходимость, Фату, Радон—Никодим, Фубини.



#focus-slide[
  Вопросы? 
]