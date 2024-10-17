#import "@preview/cetz:0.1.2": canvas, draw

// Document
#set document(title: "引力と斥力を制御可能なべき集合上の分布族", author: "Takahiro Kawashima")

// Text
#let fcolor = rgb("#28282f")
#let blue = rgb("#44aec6")
#let transblue = rgb("#44aec64d")
#let orange = rgb("#f5ab18")
#let transorange = rgb("#f5ab184d")

#set par(justify: true)
#set text(font: "Hiragino Kaku Gothic Pro", fill: fcolor, weight: "regular")
#set strong(delta: 200)
#set highlight(fill: transblue, top-edge: 0.25em)

// Equations
//#set math.equation(numbering: "(1)")

// Headings
#show heading: set text(size: 1em, weight: "medium")
#show heading: set block(above: 1.5em, below: 1em)

// Lists
#set list(tight: true, marker: strong("•"))
#set enum(tight: true)

// Commands
#let etr = math.upright([etr])

// Figures
#set figure.caption(separator: [. ])

// Poster
#let poster(body) = {
    // Page
    set page(paper: "a4", flipped: false, margin: 0.75cm)

    // Social
    let social(url, logo, body) = {
        link(url, stack(dir: ltr, spacing: 0.5em, image(logo, height: 1.25em), text(size: 1.25em, body)))
    }

    // Layout
    grid(
        rows: (1.5cm, 1fr),
        row-gutter: 1.0cm,
          stack(
            dir:ttb,
            spacing: 1.0em,
            grid(
              //columns: (1fr, auto, 1fr),
              columns: (auto, 1fr),
              // Title
              align(
                  horizon + center,
                  stack(
                      dir: ttb,
                      spacing: 1em,
                      text(size: 1.75em, weight: "medium", [引力と斥力を制御可能なべき集合上の分布族]),
                      text(size: 1.2em, [川島貴大 (ZOZO Research)，日野英逸（統数研・理研AIP）]),
                  )
              ),
              // Logos
              /*
              align(
                  horizon + center,
                  stack(
                      dir: ltr,
                      spacing: 1.5cm,
                      image("imgs/next_ism_aip_.svg", height: 0.8cm),
                  ),
              ),
              */
              // Logos & Links
              align(
                  horizon + center,
                  stack(
                      dir: ttb,
                      spacing: 1.0em,
                      image("imgs/next_ism_aip_.svg", height: 0.55cm),
                      social("https://arxiv.org/abs/2408.01022", "imgs/arxiv.svg", `arXiv:2408.01022`),
                  ),
              ),
            ),
            align(center, line(length: 80%, stroke: 1.5pt + fcolor)),
          ),
        columns(2, gutter: 0.5cm, body),
    )
}

#show: poster

// Body
== #highlight[背景]
台集合 $cal(Y) = {1, dots.h, N}$ からランダムに部分集合をとりだすための確率モデルを考えたい\
#h(1em)#sym.triangle.stroked.small.r 実験計画，推薦システム，確率的最適化，#sym.dots.h#sym.dots.h\

#text(blue)[*引力*]と#text(blue)[*斥力*]が重要！
#image("imgs/2d_samples.svg", width: 100%)

計算機的に扱いやすく，引力と斥力を制御可能な確率モデルはこれまでなかった\
#h(1em)#sym.triangle.stroked.small.r #highlight(fill: transorange)[これらを実現する分布族*DKPP*を提案！]


#let theorem(body) = [#counter("theorem").step() *Theorem #counter("theorem").display().* #body]

#let showcase(body) = {
    rect(fill: rgb("#f5f5f7"), inset: 0.25cm, radius: 0.15cm, width: 100%, body)
}

== #highlight[提案モデル：DKPP]
#showcase(
  [*DKPP（離散カーネル点過程）*
    $
      P_(phi)(cal(A); bold(L)) = (etr(phi(bold(L)[cal(A)]))) / (Z_(phi)(bold(L)))
    $
    $phi$：連続関数\
    $bold(L)$：$N times N$の正定値カーネル行列
  ]
)
#h(1em)#sym.triangle.stroked.small.r $bold(L)$ がアイテム間類似度を，$phi$ が引力・斥力を制御

=== #highlight[モデルの包含関係]
#align(center)[#image("imgs/dkpp_venn_diagram.svg", width: 70%)]
結合係数がすべて正or負のボルツマンマシン，行列式点過程 (DPP) を内包

=== #highlight[DKPPの引力・斥力]
集合関数 $log P(cal(A))$ が
#list(
  tight: true,
  indent: 1em,
  [優モジュラ #sym.arrow 引力],
  [劣モジュラ #sym.arrow 斥力]
)
DKPPでは，$phi$ の導関数 $phi'$ が
#list(
  tight: true,
  indent: 1em,
  [#highlight(fill: transorange)[作用素単調増加 #sym.arrow 優モジュラ #sym.arrow 引力]],
  [#highlight(fill: transorange)[作用素単調減少 #sym.arrow 劣モジュラ #sym.arrow 斥力]]
)
#place(
  bottom + left,
  dx: 12em,
  dy: -7em,
  rect(
    radius: 0.25cm,
    inset: 7.5pt,
    stroke: 2pt + blue,
    text(
      size: 12pt,
    )[
      *作用素単調増加性*：\
      $bold(A) prec.eq bold(B) arrow.r.double f(bold(A)) prec.eq f(bold(B))$
    ]
  )
)

#colbreak()

== #highlight[DKPPの計算機上での扱い]

/*
=== #highlight[サンプリング]
MCMCでがんばる
*/

=== #highlight[モード探索]
$max_(cal(A) subset.eq cal(Y)) log P_(phi)(cal(A); bold(L))$
#list(
  tight: true,
  indent: 1em,
  [
    $log P_(phi)$ が優モジュラ #sym.arrow #text(blue)[*劣モジュラ最小化問題*]
    #list(
      tight: true,
      marker: sym.triangle.stroked.small.r,
      [#highlight(fill: transorange)[多項式時間で解ける]]
    )
  ],
  [
    $log P_(phi)$ が劣モジュラ #sym.arrow #text(blue)[*劣モジュラ最大化問題*]
    #list(
      tight: true,
      marker: sym.triangle.stroked.small.r,
      [#highlight(fill: transorange)[貪欲法ベースのアルゴリズムで近似解が求まる]]
    )
  ],
)

=== #highlight[周辺確率・条件付き確率]

$bb(P)(cal(A)_(upright(i n)) subset.eq cal(A) subset.eq cal(A)_(upright(o u t)))$ や $bb(P)(|cal(A)| = k )$ のような周辺確率は
#text(fill: blue)[*Rao--Blackwell化重点サンプリング*]で効率的に推定\

Box--Cox変換 $phi_lambda (x)$ の $lambda in [0, 2]$ を動かし条件付き確率 $P_(phi_lambda)(cal(A) | |cal(A)| = k; bold(L))$ を評価\
#h(1em)#sym.triangle.stroked.small.r $lambda in [0, 1]$ で斥力，$lambda in [1, 2]$ で引力
#grid(
  columns: (auto, 73%),
  column-gutter: 1.0em,
  stack(
    dir: ttb,
    spacing: 0.5em,
    image("imgs/grid_scatter_25_400.svg", width: 100%),
    image("imgs/grid_gather_25_400.svg", width: 100%),
  ),
  image("imgs/cond_probs_scatter_gather.svg", width: 100%)
)
#place(
  top + right,
  dx: -1em,
  dy: 29em,
  rect(
    radius: 0.15cm,
    inset: 5.0pt,
    stroke: 1.0pt + blue,
    text(
      dir: ltr,
      size: 8pt,
    )[
      $lambda = 1$ でスイッチ
    ]
  )
)
#h(1em)#sym.triangle.stroked.small.r #highlight(fill: transorange)[たしかに引力・斥力が制御されている！]\

=== #highlight[正規化定数]
$Z_phi (bold(L))$ は#text(blue)[*平均場近似 + 重点サンプリング*]で推定
#grid(
  columns: 2,
  column-gutter: 1.0em,
  image("imgs/DKPP_logZ_gaps_is.svg", width: 100%),
  image("imgs/DKPP_logZ_is_varlogZ_n64.svg", width: 100%),
)
#h(1em)#sym.triangle.stroked.small.r #highlight(fill: transorange)[不偏性&低バリアンス性を実現]

=== #highlight[パラメータの学習]
カーネル行列の学習には#text(blue)[*Ratio Matching*]が有効
#showcase(
  [*Ratio Matching による損失関数*
    $
      J(bold(L)) = 1 / M sum^N_(n = 1) sum^M_(m = 1) frac(etr(phi(bold(L)[cal(A)^overline(n)_m])), etr(phi(bold(L)[cal(A)_m])) + etr(phi(bold(L)[cal(A)^overline(n)_m])))
    $
  ]
)
#h(1em)#sym.triangle.stroked.small.r #highlight(fill: transorange)[正規化定数の計算を回避&ミニバッチ化]
