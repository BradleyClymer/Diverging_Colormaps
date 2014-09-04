load penny.mat
contour( P , 15 )
axis ij square
shading flat
a = allchild( gca )
a = allchild( a( end ) )
v = findobj( a , 'LineSmoothing' , 'off' )
set( v , 'LineSmoothing' , 'on' , 'LineWidth' , 8 )
renderer    = 'painters' ;
export_fig( [ 'Stoked_abe_' renderer '.pdf' ] , '-m2' , [ '-' renderer ] , '-a4' ,  '-transparent' )
winopen( [ 'Stoked_abe_' renderer '.pdf' ] )

