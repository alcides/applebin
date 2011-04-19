if !exists('loaded_snips')
	fini
en

" \begin{}...\end{}
exe "Snip begin \\begin{${1:env}}\n\t${2}\n\\end{$1}"
" Tabular
exe "Snip tab \\begin{${1:tabular}}{${2:c}}\n${3}\n\\end{$1}"
" Align(ed)
exe "Snip ali \\begin{align${1:ed}}\n\t${2}\n\\end{align$1}"
" Gather(ed)
exe "Snip gat \\begin{gather${1:ed}}\n\t${2}\n\\end{gather$1}"
" Equation
exe "Snip eq \\begin{equation}\n\t${1}\n\\end{equation}"
" Unnumbered Equation
exe "Snip \\ \\\\[\n\t${1}\n\\\\]"
" Enumerate
exe "Snip enum \\begin{enumerate}\n\t\\item ${1}\n\\end{enumerate}"
" Itemize
exe "Snip item \\begin{itemize}\n\t\\item ${1}\n\\end{itemize}"
" Description
exe "Snip desc \\begin{description}\n\t\\item[${1}] ${2}\n\\end{description}"
" Matrix
exe "Snip mat \\begin{${1:p/b/v/V/B/small}matrix}\n\t${2}\n\\end{$1matrix}"
" Cases
exe "Snip cas \\begin{cases}\n\t${1:equation}, &\\text{ if }${2:case}\\\\\n\t${3}\n\\end{cases}"
" Split
exe "Snip spl \\begin{split}\n\t${1}\n\\end{split}"
" Part
exe "Snip part \\part{${1:part name}} % (fold)\n\\label{prt:${2:$1}}\n${3}\n% part $2 (end)"
" Chapter
exe "Snip cha \\chapter{${1:chapter name}} % (fold)\n\\label{cha:${2:$1}}\n${3}\n% chapter $2 (end)"
" Section
exe "Snip sec \\section{${1:section name}} % (fold)\n\\label{sec:${2:$1}}\n${3}\n% section $2 (end)"
" Sub Section
exe "Snip sub \\subsection{${1:subsection name}} % (fold)\n\\label{sub:${2:$1}}\n${3}\n% subsection $2 (end)"
" Sub Sub Section
exe "Snip subs \\subsubsection{${1:subsubsection name}} % (fold)\n\\label{ssub:${2:$1}}\n${3}\n% subsubsection $2 (end)"
" Paragraph
exe "Snip par \\paragraph{${1:paragraph name}} % (fold)\n\\label{par:${2:$1}}\n${3}\n% paragraph $2 (end)"
" Sub Paragraph
exe "Snip subp \\subparagraph{${1:subparagraph name}} % (fold)\n\\label{subp:${2:$1}}\n${3}\n% subparagraph $2 (end)"
exe 'Snip itd \\item[${1:description}] ${2:item}'
exe 'Snip figure ${1:Figure}~\\ref{${2:fig:}}${3}'
exe 'Snip table ${1:Table}~\\ref{${2:tab:}}${3}'
exe 'Snip listing ${1:Listing}~\\ref{${2:list}}${3}'
exe 'Snip section ${1:Section}~\\ref{${2:sec:}}${3}'
exe 'Snip page ${1:page}~\\pageref{${2}}${3}'
