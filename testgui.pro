

pro WID_BASE_0



device, decomposed = 0
loadct, 0

screen_size = GetPrimaryScreenSize(/EXCLUDE_TASKBAR)
tlb_width = fix(0.9*screen_size[0])
tlb_height = fix(0.99*screen_size[1])

base0 = Widget_base(uname='base0', SCR_XSIZE=tlb_width ,SCR_YSIZE=tlb_height)
t1 = Widget_tab(base0)
WID_BASE_01 = Widget_Base(t1,UNAME='WID_BASE_0', SCR_XSIZE=tlb_width ,SCR_YSIZE=tlb_height,TITLE='IDL')
WID_BASE_1 = Widget_base(t1, uname='WID_BASE_1', SCR_XSIZE=tlb_width ,SCR_YSIZE=tlb_height, TITLE='MFP')

col1 = (1.0/2.5)*tlb_width
col2 = (2.0/5)*col1
y_height = 30



WID_LABEL_1 = Widget_Label(WID_BASE_01, UNAME='WID_LABEL_1'   $
      ,scr_XSIZE=col1 ,scr_YSIZE=y_height  $
      ,/ALIGN_CENTER ,VALUE='Use this frame to preview data for'+ $
      ' analysis.  Load a desired file and adjust parameters until Blo'+ $
      'b Analysis is working correctly, then proceed to full analysis '+ $
      'run.')

files_button = Widget_button(WID_BASE_01, uname='files_button',yoffset = y_height, scr_xsize = col1/5, value='Select Files', scr_ysize=y_height)
current_button = Widget_button(WID_BASE_01, uname='current_button',yoffset = y_height, scr_xsize = col1/5, value='Show current', scr_ysize=y_height, xoffset = col1/5)
back_button = Widget_button(WID_BASE_01, uname='back_button',yoffset = y_height, scr_xsize = col1/5, value='Back', scr_ysize=y_height, xoffset = 2*col1/5)
next_button = Widget_button(WID_BASE_01, uname='next_button',yoffset = y_height, scr_xsize = col1/5, value='Next', scr_ysize=y_height, xoffset = 3*col1/5)
file_num_label = Widget_label(WID_BASE_01, uname='file_num_label',yoffset = y_height, scr_xsize = col1/10, value='File Num', scr_ysize=22, xoffset = 4*col1/5, /ALIGN_CENTER)
file_num_text = Widget_text(WID_BASE_01, uname='file_num_text',yoffset = y_height, scr_xsize = col1/10, scr_ysize=22, xoffset = 9*col1/10, /editable)

b32 = Widget_label(WID_BASE_01, uname='b32',yoffset = y_height*2, scr_xsize = col1/5, value='Current filename', scr_ysize=y_height)
b33 = Widget_button(WID_BASE_01, uname='b33',yoffset = y_height*2, scr_xsize = 4*col1/5, value='b33', scr_ysize=y_height, xoffset = col1/5)
b34 = Widget_label(WID_BASE_01, uname='b34',yoffset = y_height*3, scr_xsize = col1/5, value='Reference filename', scr_ysize=y_height)
b35 = Widget_button(WID_BASE_01, uname='b35',yoffset = y_height*3, scr_xsize = 4*col1/5, value='b35', scr_ysize=y_height, xoffset = col1/5)




b1 = Widget_button(WID_BASE_01, uname='b1', yoffset = y_height*4, scr_xsize = col2, value='b1', scr_ysize=y_height)
b2 = Widget_button(WID_BASE_01, uname='b2',yoffset = y_height*5, scr_xsize = col2/2, value='b2', scr_ysize=y_height)
b3 = Widget_button(WID_BASE_01, uname='b3',yoffset = y_height*6, scr_xsize = col2/2, value='b3', scr_ysize=y_height)
b4 = Widget_button(WID_BASE_01, uname='b4',yoffset = y_height*7, scr_xsize = col2/2, value='b4', scr_ysize=y_height)
b5 = Widget_button(WID_BASE_01, uname='b5',yoffset = y_height*8, scr_xsize = col2/2, value='b5', scr_ysize=y_height)

b6 = Widget_button(WID_BASE_01, uname='b6', yoffset = y_height*5, scr_xsize = col2/2, value='b6', xoffset=col2/2, scr_ysize=y_height)
b7 = Widget_button(WID_BASE_01, uname='b6', yoffset = y_height*6, scr_xsize = col2/2, value='b7', xoffset=col2/2, scr_ysize=y_height)
b8 = Widget_button(WID_BASE_01, uname='b6', yoffset = y_height*7, scr_xsize = col2/2, value='b8', xoffset=col2/2, scr_ysize=y_height)
b9 = Widget_button(WID_BASE_01, uname='b6', yoffset = y_height*8, scr_xsize = col2/2, value='b9', xoffset=col2/2, scr_ysize=y_height)

b10 = Widget_button(WID_BASE_01, uname='b10', yoffset = y_height*4, scr_xsize = col2, value='b10', xoffset=col2, scr_ysize=y_height)
b11 = Widget_button(WID_BASE_01, uname='b11',yoffset = y_height*5, scr_xsize = col2, value='b11', xoffset=col2, scr_ysize=y_height)
b12 = Widget_button(WID_BASE_01, uname='b12',yoffset = y_height*6, scr_xsize = col2, value='b12', xoffset=col2, scr_ysize=y_height)

b13 = Widget_button(WID_BASE_01, uname='b13',yoffset = y_height*7, scr_xsize = col2/2, value='b13', xoffset=col2, scr_ysize=y_height)
b14 = Widget_button(WID_BASE_01, uname='b14',yoffset = y_height*7, scr_xsize = col2/2, value='b14', xoffset=col2+col2/2, scr_ysize=y_height)

b15 = Widget_button(WID_BASE_01, uname='b15',yoffset = y_height*8, scr_xsize = col2/4, value='b15', xoffset=col2, scr_ysize=y_height)
b16 = Widget_button(WID_BASE_01, uname='b16',yoffset = y_height*8, scr_xsize = col2/4, value='b16', xoffset=col2+col2/4, scr_ysize=y_height)
b17 = Widget_button(WID_BASE_01, uname='b17',yoffset = y_height*8, scr_xsize = col2/4, value='b17', xoffset=col2+col2/2, scr_ysize=y_height)
b18 = Widget_button(WID_BASE_01, uname='b18',yoffset = y_height*8, scr_xsize = col2/4, value='b18', xoffset=col2+col2*(3.0/4), scr_ysize=y_height)

b19 = Widget_button(WID_BASE_01, uname='b19', yoffset = y_height*4, scr_xsize = col2/2, value='b19', xoffset=2*col2, scr_ysize=y_height)
b20 = Widget_button(WID_BASE_01, uname='b20',yoffset = y_height*5, scr_xsize = col2/2, value='b20', xoffset=2*col2, scr_ysize=y_height)
b21 = Widget_button(WID_BASE_01, uname='b21',yoffset = y_height*6, scr_xsize = col2/2, value='b21', xoffset=2*col2, scr_ysize=y_height)
b22 = Widget_button(WID_BASE_01, uname='b22',yoffset = y_height*7, scr_xsize = col2/2, value='b22', xoffset=2*col2, scr_ysize=y_height)
b23 = Widget_button(WID_BASE_01, uname='b23',yoffset = y_height*8, scr_xsize = col2/2, value='b23', xoffset=2*col2, scr_ysize=y_height)
b24 = Widget_button(WID_BASE_01, uname='b24',yoffset = y_height*9, scr_xsize = col2/2, value='b24', xoffset=2*col2, scr_ysize=y_height)

b25 = Widget_button(WID_BASE_01, uname='b25',yoffset = y_height*9, scr_xsize = col2*2, value='b25', scr_ysize=y_height)

c = col1/3
b36 = Widget_button(WID_BASE_01, uname='b36',yoffset = y_height*11, scr_xsize = c/2, value='b36', scr_ysize=y_height)
b37 = Widget_button(WID_BASE_01, uname='b37',yoffset = y_height*11, scr_xsize = c/2, value='b37', scr_ysize=y_height, xoffset=c/2)
b38 = Widget_button(WID_BASE_01, uname='b38',yoffset = y_height*11, scr_xsize = c/2, value='b38', scr_ysize=y_height, xoffset=c)
b39 = Widget_button(WID_BASE_01, uname='b39',yoffset = y_height*11, scr_xsize = c/2, value='b39', scr_ysize=y_height, xoffset=3*c/2)
b40 = Widget_button(WID_BASE_01, uname='b40',yoffset = y_height*11, scr_xsize = c/2, value='b40', scr_ysize=y_height, xoffset=c*2)
b41 = Widget_button(WID_BASE_01, uname='b41',yoffset = y_height*11, scr_xsize = c/2, value='b41', scr_ysize=y_height, xoffset=5*c/2)

b42 = Widget_draw(WID_BASE_01, uname='b42',yoffset = y_height*12, scr_xsize = col1, scr_ysize=y_height*4)

b43 = Widget_button(WID_BASE_01, uname='b43',yoffset = y_height*16, scr_xsize = col1/4, value='b43', scr_ysize=y_height)
b44 = Widget_button(WID_BASE_01, uname='b44',yoffset = y_height*16, scr_xsize = col1/4, value='b44', scr_ysize=y_height, xoffset=col1/4)
b45 = Widget_button(WID_BASE_01, uname='b45',yoffset = y_height*16, scr_xsize = col1/4, value='b45', scr_ysize=y_height, xoffset=col1/2)
b46 = Widget_button(WID_BASE_01, uname='b46',yoffset = y_height*16, scr_xsize = col1/4, value='b46', scr_ysize=y_height, xoffset=3*col1/4)



b47 = Widget_button(WID_BASE_01, uname='b47', scr_xsize = tlb_width-col1-20, value='b47', scr_ysize=y_height, xoffset=col1)


;b1 = Widget_Button(UNAME='b1', xoffset=5, yoffset=5,


Widget_Control, /REALIZE, WID_BASE_01

XManager, 'WID_BASE_0', WID_BASE_01, /NO_BLOCK

end





pro testgui
  ;WID_BASE_01
end