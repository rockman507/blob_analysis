pro AlignColumns, ColumnBase
   compile_opt idl2
;http://idldatapoint.wordpress.com/2012/02/23/aligning-widgets/
   ; The outer loop iterates over the rows in the column base.
   columnmaxwidths = [0]
   child = widget_info(ColumnBase, /CHILD)
   while (widget_info(child, /VALID_ID)) do begin

      ; The inner loop iterates over the widgets in each row.
      ; The number of widgets in this base is interpreted
      ; as the number of columns.
      columncount = 0L
      grandchild = widget_info(child, /CHILD)
      while (widget_info(grandchild, /VALID_ID)) do begin

         ; What is the screen width in pixels of this widget?
         width = (widget_info(grandchild, /GEOMETRY)).scr_xsize

         ; If this is a new column, record its width, otherwise
         ; take the maximum of this width and the previous
         ; recorded maximum width.
         if (n_elements(columnmaxwidths) lt columncount + 1) then begin
            columnmaxwidths = [columnmaxwidths, width]
         endif else begin
            columnmaxwidths[columncount] >= width
         endelse

         columncount++
         grandchild = widget_info(grandchild, /SIBLING)
      endwhile

      child = widget_info(child, /SIBLING)
   endwhile

   ; Pass 2: Set the screen width of each widget equal
   ; to the maximum width found per column
   child = widget_info(ColumnBase, /CHILD)
   while (widget_info(child, /VALID_ID)) do begin

      columncount = 0L
      grandchild = widget_info(child, /CHILD)

      while (widget_info(grandchild, /VALID_ID)) do begin
         widget_control, grandchild, SCR_XSIZE = columnmaxwidths[columncount]
         columncount++
         grandchild = widget_info(grandchild, /SIBLING)
      endwhile

      child = widget_info(child, /SIBLING)
   endwhile
end