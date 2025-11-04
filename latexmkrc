$pdf_mode = 1;
$interaction = 'nonstopmode';
$aux_dir = '_build';
$out_dir = 'dist';
$bibtex_use = 2;

# Use XeLaTeX
$pdflatex = 'xelatex %O %S';
$xelatex = 'xelatex %O %S';

add_cus_dep('glo','gls',0,'makeglossaries');
