param N;
param s := 0;
param e := N+1;
param p {s..e, s..e};
var x {i in s..e, j in s..e} >= 0;#wykozystana przepustowo��
var d {i in s..e, j in s..e} >= 0;#wydzier�awione ��cze (rozbudowa)
param kos {s..e, s..e};#koszty dzier�awienia na jednostk�
param kar {s..e, s..e};#kara jednostkowa za niedotrzymanie umowy dla istniej�cych klient�w
param cen {s..e, s..e};#cena (przych�d) za dostarczenie jednostki
maximize Q: (sum {i in s..e} x[i,e]*cen[i,e]) - (sum {i in s..e} (kar[i,e]*(p[i,e]-x[i,e]))) - (sum {i in s..e, j in s..i} d[i,j]*kos[i,j]);
subject to ogr3 {i in 1..N, j in 1..e}: x[i,j]+x[j,i]<=p[i,j]+d[i,j];
subject to ogr4 {j in 1..N}: sum {i in s..e} (x[i,j]- x[j,i]) = 0;
subject to ogr5 {j in s..e}: x[s,j]<=p[s,j];
subject to ogr6 {i in s..e}: x[i,s]<=0;
subject to ogr7 {i in s..e}: x[i,e]<=p[i,e];
subject to ogr8 {j in s..e}: x[e,j]<=0;
subject to ogr9: sum {j in s..e} x[s,j]<=999;