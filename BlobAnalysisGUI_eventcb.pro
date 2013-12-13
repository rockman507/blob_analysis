;
; IDL Event Callback Procedures
; BlobAnalysisGUI_eventcb
;
; Generated on:	02/25/2011 11:57.43
;

; Written by Brian Primeau
; Last updated in 2011

; Changelog:
; Changed DIALOG_PICKFILE calls to filter for desired filetypes 						JS 20130520
; Changed CD so it's only called once for the pick file dialog 							JS 20130520
; Made opening files automatically call ShowCurrent to avoid opening ritual sacrifice 	JS 20130528
; Reverse wedge factor ended up masking entire data array, fixed 						JS 20130529
; OnAnalyzePreview was ignoring an image with only 1 blob, erroring in multiple spots,
;  added conditional check for 1 blob,													JS 20130530
; ShowOverlay was using wrong scaling for the draw blob, changed to use device			JS 20130725
; ShowAll changed to TVImage in place of TVscl, shows images properly now				JS 20130725
; Device, Decomposed = 0 added to allow for color										JS 20130725
; Complete rewrite of ReadText to read in binary files and a mask binary file			JS 20130725
; GUI rewritten:
;   allow different resolutions (1024x786 up to 1680x1050) 								JS 20130729
;   resize histograms to all the same size  											JS 20130729
; Perform a shift to the histogram data arrays so they start off with 0  				JS 20130729
; OnNext and OnBack call ShowOriginal													JS 20130730
;


; Open things to be done:
;


; If FSC_Color errors for overlay, add coyote to IDL path
; If ReadText errors randomly, add code folder to IDL path

;-----------------------------------------------------------------
; Activate Button Callback Procedure.
; Argument:
;-----------------------------------------------------------------
pro SelectMultipleFiles, Event
;CD, 'D:\data\'
FileList = DIALOG_PICKFILE(/MULTIPLE_FILES, TITLE='Select Multiple Files For Analysis', filter='*.dat')
indices = sort(FileList)
FileList = FileList[indices]

WID_BUTTON_21 = Widget_Info(Event.top, FIND_BY_UNAME='WID_BUTTON_21')
WIDGET_CONTROL, WID_BUTTON_21,  set_uvalue = FileList

NumFiles = N_ELEMENTS(Filelist)

WID_TEXT_24 = Widget_Info(Event.top, FIND_BY_UNAME='WID_TEXT_24')
WIDGET_CONTROL, WID_TEXT_24,  set_value = '1'
WID_TEXT_6 = Widget_Info(Event.top, FIND_BY_UNAME='WID_TEXT_6')
WIDGET_CONTROL, WID_TEXT_6,  set_value = strtrim(string(NumFiles),2)
OnShowPreview, Event

end

;-----------------------------------------------------------------
; Activate Button Callback Procedure.
; Argument:
;-----------------------------------------------------------------
pro OnShowPreview, Event

WID_BUTTON_10 = Widget_Info(Event.top, FIND_BY_UNAME='WID_BUTTON_10')
ScaleStatus = Widget_Info(WID_BUTTON_10, /BUTTON_SET)

WID_TEXT_24 = Widget_Info(Event.top, FIND_BY_UNAME='WID_TEXT_24')
WIDGET_CONTROL, WID_TEXT_24,  get_value = i
i = fix(i(0))

WID_BUTTON_21 = Widget_Info(Event.top, FIND_BY_UNAME='WID_BUTTON_21')
WIDGET_CONTROL, WID_BUTTON_21,  get_uvalue = FileList
filename = FileList(i-1)

WID_TEXT_0 = Widget_Info(Event.top, FIND_BY_UNAME='WID_TEXT_0')
WIDGET_CONTROL, WID_TEXT_0,  set_value = filename
mask = 0
data = readtext(filename, mask)
IF ScaleStatus eq 1 THEN data=-data  ; no need to change, it works  <- vicious lies!
;data = (data + abs(min(data)))*mask

WID_BUTTON_20 = Widget_Info(Event.top, FIND_BY_UNAME='WID_BUTTON_20')
WIDGET_CONTROL, WID_BUTTON_20,  set_uvalue = data

data = (data + abs(min(data)))*mask


WID_BUTTON_22 = Widget_Info(Event.top, FIND_BY_UNAME='WID_BUTTON_22')
WIDGET_CONTROL, WID_BUTTON_22,  set_uvalue = mask

WID_DRAW_0 = Widget_Info(Event.top, FIND_BY_UNAME='WID_DRAW_0')
WIDGET_CONTROL, WID_DRAW_0,  get_value = win_num
;loadct, 13
loadct, 0
wset, win_num
Device, Decomposed = 0
tvscl, data
;loadct, 0
end

;-----------------------------------------------------------------
; Activate Button Callback Procedure.
; Argument:
;-----------------------------------------------------------------
pro OnNext, Event

; get FileList
WID_BUTTON_21 = Widget_Info(Event.top, FIND_BY_UNAME='WID_BUTTON_21')
WIDGET_CONTROL, WID_BUTTON_21,  get_uvalue = FileList

; get current file index
WID_TEXT_24 = Widget_Info(Event.top, FIND_BY_UNAME='WID_TEXT_24')
WIDGET_CONTROL, WID_TEXT_24,  get_value = i
i=fix(i(0))

; update index
NumFiles = N_ELEMENTS(Filelist)
i = ((i+NumFiles) mod NumFiles) + 1 ; new i with wrapping
WIDGET_CONTROL, WID_TEXT_24,  set_value = strtrim(string(i),2)

; get and save new file name
filename = FileList(i-1)
WID_TEXT_0 = Widget_Info(Event.top, FIND_BY_UNAME='WID_TEXT_0')
WIDGET_CONTROL, WID_TEXT_0,  set_value = filename

WID_BUTTON_10 = Widget_Info(Event.top, FIND_BY_UNAME='WID_BUTTON_10')
ScaleStatus = Widget_Info(WID_BUTTON_10, /BUTTON_SET)


data = readtext(filename)
IF ScaleStatus eq 1 THEN data=-data
WID_BUTTON_20 = Widget_Info(Event.top, FIND_BY_UNAME='WID_BUTTON_20')
WIDGET_CONTROL, WID_BUTTON_20,  set_uvalue = data
OnShowOriginal, Event

end
;-----------------------------------------------------------------
; Activate Button Callback Procedure.
; Argument:
;-----------------------------------------------------------------
pro OnBack, Event

; get FileList
WID_BUTTON_21 = Widget_Info(Event.top, FIND_BY_UNAME='WID_BUTTON_21')
WIDGET_CONTROL, WID_BUTTON_21,  get_uvalue = FileList

; get current file index
WID_TEXT_24 = Widget_Info(Event.top, FIND_BY_UNAME='WID_TEXT_24')
WIDGET_CONTROL, WID_TEXT_24,  get_value = i

; update index
i=fix(i(0))
NumFiles = N_ELEMENTS(Filelist)
i = ((i-2+NumFiles) mod NumFiles) + 1 ; new i with wrapping
WIDGET_CONTROL, WID_TEXT_24,  set_value = strtrim(string(i),2)

; get and update new file name
filename = FileList(i-1)
WID_TEXT_0 = Widget_Info(Event.top, FIND_BY_UNAME='WID_TEXT_0')
WIDGET_CONTROL, WID_TEXT_0,  set_value = filename

WID_BUTTON_10 = Widget_Info(Event.top, FIND_BY_UNAME='WID_BUTTON_10')
ScaleStatus = Widget_Info(WID_BUTTON_10, /BUTTON_SET)

data = readtext(filename)
IF ScaleStatus eq 1 THEN data=-data
WID_BUTTON_20 = Widget_Info(Event.top, FIND_BY_UNAME='WID_BUTTON_20')
WIDGET_CONTROL, WID_BUTTON_20,  set_uvalue = data
OnShowOriginal, Event
end

;-----------------------------------------------------------------
; Activate Button Callback Procedure.
; Argument:
;-----------------------------------------------------------------
pro OnSetReference, Event

WID_BUTTON_20 = Widget_Info(Event.top, FIND_BY_UNAME='WID_BUTTON_20')
WIDGET_CONTROL, WID_BUTTON_20,  get_uvalue = reference

WID_BUTTON_22 = Widget_Info(Event.top, FIND_BY_UNAME='WID_BUTTON_22')
WIDGET_CONTROL, WID_BUTTON_22,  get_uvalue = mask

reference = reference*mask

WID_BUTTON_11 = Widget_Info(Event.top, FIND_BY_UNAME='WID_BUTTON_11')
WIDGET_CONTROL, WID_BUTTON_11,  set_uvalue = reference

WID_TEXT_0 = Widget_Info(Event.top, FIND_BY_UNAME='WID_TEXT_0')
WIDGET_CONTROL, WID_TEXT_0,  get_value = filename
WID_TEXT_25 = Widget_Info(Event.top, FIND_BY_UNAME='WID_TEXT_25')
WIDGET_CONTROL, WID_TEXT_25,  set_value = filename

end

;-----------------------------------------------------------------
; Activate Button Callback Procedure.
; Argument:
;-----------------------------------------------------------------
pro OnSetScale, Event
WID_BUTTON_21 = Widget_Info(Event.top, FIND_BY_UNAME='WID_BUTTON_21')
WIDGET_CONTROL, WID_BUTTON_21,  get_uvalue = FileList
WID_TEXT_6 = Widget_Info(Event.top, FIND_BY_UNAME='WID_TEXT_6')
WIDGET_CONTROL, WID_TEXT_6,  get_value = NumFiles
WID_BUTTON_11 = Widget_Info(Event.top, FIND_BY_UNAME='WID_BUTTON_11')
WIDGET_CONTROL, WID_BUTTON_11,  get_uvalue = reference
WID_BUTTON_19 = Widget_Info(Event.top, FIND_BY_UNAME='WID_BUTTON_19')
RefStatus = Widget_Info(WID_BUTTON_19, /BUTTON_SET)
WID_BUTTON_22 = Widget_Info(Event.top, FIND_BY_UNAME='WID_BUTTON_22')
WIDGET_CONTROL, WID_BUTTON_22,  get_uvalue = mask
WID_BUTTON_10 = Widget_Info(Event.top, FIND_BY_UNAME='WID_BUTTON_10')
ScaleStatus = Widget_Info(WID_BUTTON_10, /BUTTON_SET)

data = readtext(Filelist(fix(NumFiles(0))-1))

IF ScaleStatus eq 1 THEN data=-data

IF RefStatus eq 1 THEN BEGIN
	measurement = (data - reference)*mask
	measurement = (measurement + abs(min(measurement)))*mask
ENDIF ELSE BEGIN
	measurement = (data + abs(min(data*mask)))*mask
ENDELSE

WID_TEXT_8 = Widget_Info(Event.top, FIND_BY_UNAME='WID_TEXT_8')
WIDGET_CONTROL, WID_TEXT_8,  set_value = strtrim(string(max(measurement)),2)
WID_BUTTON_24 = Widget_Info(Event.top, FIND_BY_UNAME='WID_BUTTON_24')
WIDGET_CONTROL, WID_BUTTON_24,  set_uvalue = measurement

end
;-----------------------------------------------------------------
; Activate Button Callback Procedure.
; Argument:
;-----------------------------------------------------------------
pro OnShowOriginal, Event

WID_BUTTON_20 = Widget_Info(Event.top, FIND_BY_UNAME='WID_BUTTON_20')
WIDGET_CONTROL, WID_BUTTON_20,  get_uvalue = data
WID_BUTTON_11 = Widget_Info(Event.top, FIND_BY_UNAME='WID_BUTTON_11')
WIDGET_CONTROL, WID_BUTTON_11,  get_uvalue = reference
WID_BUTTON_19 = Widget_Info(Event.top, FIND_BY_UNAME='WID_BUTTON_19')
RefStatus = Widget_Info(WID_BUTTON_19, /BUTTON_SET)
WID_BUTTON_22 = Widget_Info(Event.top, FIND_BY_UNAME='WID_BUTTON_22')
WIDGET_CONTROL, WID_BUTTON_22,  get_uvalue = mask

IF RefStatus eq 1 THEN BEGIN
	measurement = (data - reference)*mask
	measurement = (measurement + abs(min(measurement)))*mask
ENDIF ELSE BEGIN
	measurement = (data + abs(min(data*mask)))*mask
ENDELSE

WID_DRAW_0 = Widget_Info(Event.top, FIND_BY_UNAME='WID_DRAW_0')			;Draw widget address
WIDGET_CONTROL, WID_DRAW_0,  get_value = win_num
loadct, 0
wset, win_num
tvscl, measurement
;loadct 0

WID_TEXT_4 = Widget_Info(Event.top, FIND_BY_UNAME='WID_TEXT_4')
WIDGET_CONTROL, WID_TEXT_4,  set_value = strtrim(string(min(measurement)),2)
WID_TEXT_7 = Widget_Info(Event.top, FIND_BY_UNAME='WID_TEXT_7')
WIDGET_CONTROL, WID_TEXT_7,  set_value = strtrim(string(max(measurement)),2)

end

;-----------------------------------------------------------------
; Activate Button Callback Procedure.
; Argument:
;-----------------------------------------------------------------
pro OnShowUnsharp, Event

WID_TEXT_1 = Widget_Info(Event.top, FIND_BY_UNAME='WID_TEXT_1')
WID_TEXT_2 = Widget_Info(Event.top, FIND_BY_UNAME='WID_TEXT_2')
WID_TEXT_3 = Widget_Info(Event.top, FIND_BY_UNAME='WID_TEXT_3')

WIDGET_CONTROL, WID_TEXT_1,  get_value = UnsharpRadius

WID_BUTTON_20 = Widget_Info(Event.top, FIND_BY_UNAME='WID_BUTTON_20')
WIDGET_CONTROL, WID_BUTTON_20,  get_uvalue = data
WID_BUTTON_11 = Widget_Info(Event.top, FIND_BY_UNAME='WID_BUTTON_11')
WIDGET_CONTROL, WID_BUTTON_11,  get_uvalue = reference
WID_BUTTON_19 = Widget_Info(Event.top, FIND_BY_UNAME='WID_BUTTON_19')
RefStatus = Widget_Info(WID_BUTTON_19, /BUTTON_SET)
WID_BUTTON_22 = Widget_Info(Event.top, FIND_BY_UNAME='WID_BUTTON_22')
WIDGET_CONTROL, WID_BUTTON_22,  get_uvalue = mask
WID_TEXT_8 = Widget_Info(Event.top, FIND_BY_UNAME='WID_TEXT_8')
WIDGET_CONTROL, WID_TEXT_8,  get_value = MaxVal
MaxVal = fix(MaxVal(0))

IF RefStatus eq 1 THEN BEGIN
	measurement = (data - reference)*mask
	measurement = (measurement + abs(min(measurement)))*mask
ENDIF ELSE BEGIN
	measurement = (data + abs(min(data*mask)))*mask
ENDELSE

scaled = bytscl(measurement, MIN = 0, MAX = MaxVal)

unsharp = UNSHARP_MASK(scaled, RADIUS = fix(UnsharpRadius(0))) - scaled

WID_DRAW_0 = Widget_Info(Event.top, FIND_BY_UNAME='WID_DRAW_0')			;Draw widget address
WIDGET_CONTROL, WID_DRAW_0,  get_value = win_num
wset, win_num
loadct, 0
tv, unsharp
end

;-----------------------------------------------------------------
; Activate Button Callback Procedure.
; Argument:
;-----------------------------------------------------------------
pro OnShowOpenImage, Event

; Shows the smoothed and filtered image, which is used to define the mask, eventually passed to
; the blob analyzer.

WID_TEXT_1 = Widget_Info(Event.top, FIND_BY_UNAME='WID_TEXT_1')
WID_TEXT_2 = Widget_Info(Event.top, FIND_BY_UNAME='WID_TEXT_2')
WID_TEXT_3 = Widget_Info(Event.top, FIND_BY_UNAME='WID_TEXT_3')

WIDGET_CONTROL, WID_TEXT_1,  get_value = UnsharpRadius
WIDGET_CONTROL, WID_TEXT_2,  get_value = ThreshVal
WIDGET_CONTROL, WID_TEXT_3,  get_value = KernelRadius

WID_BUTTON_20 = Widget_Info(Event.top, FIND_BY_UNAME='WID_BUTTON_20')
WIDGET_CONTROL, WID_BUTTON_20,  get_uvalue = data
WID_BUTTON_11 = Widget_Info(Event.top, FIND_BY_UNAME='WID_BUTTON_11')
WIDGET_CONTROL, WID_BUTTON_11,  get_uvalue = reference
WID_BUTTON_19 = Widget_Info(Event.top, FIND_BY_UNAME='WID_BUTTON_19')
RefStatus = Widget_Info(WID_BUTTON_19, /BUTTON_SET)
WID_BUTTON_22 = Widget_Info(Event.top, FIND_BY_UNAME='WID_BUTTON_22')
WIDGET_CONTROL, WID_BUTTON_22,  get_uvalue = mask
WID_TEXT_8 = Widget_Info(Event.top, FIND_BY_UNAME='WID_TEXT_8')
WIDGET_CONTROL, WID_TEXT_8,  get_value = MaxVal
MaxVal = fix(MaxVal(0))

IF RefStatus eq 1 THEN BEGIN
	measurement = (data - reference)*mask
	measurement = (measurement + abs(min(measurement)))*mask
ENDIF ELSE BEGIN
	measurement = (data + abs(min(data*mask)))*mask
ENDELSE

scaled = bytscl(measurement, MIN = 0, MAX = MaxVal)

unsharp = UNSHARP_MASK(scaled, RADIUS = fix(UnsharpRadius(0))) - scaled

; Define a structuring kernal for an opening operation on the image.
radius = fix(KernelRadius(0))
kernel = SHIFT(DIST(2*radius+1), radius, radius) LE radius

; Apply the opening operator to the image.
openImage = MORPH_OPEN(unsharp, kernel, /GRAY)

WID_DRAW_0 = Widget_Info(Event.top, FIND_BY_UNAME='WID_DRAW_0')			;Draw widget address
WIDGET_CONTROL, WID_DRAW_0,  get_value = win_num

loadct, 0
wset, win_num
tvscl, openImage
;loadct 0
end
;-----------------------------------------------------------------
; Activate Button Callback Procedure.
; Argument:
;-----------------------------------------------------------------
pro OnShowMask, Event

;Displays the mask passed to the blob analysis.  This is what label_region uses to define blobs.
WID_TEXT_1 = Widget_Info(Event.top, FIND_BY_UNAME='WID_TEXT_1')
WID_TEXT_2 = Widget_Info(Event.top, FIND_BY_UNAME='WID_TEXT_2')
WID_TEXT_3 = Widget_Info(Event.top, FIND_BY_UNAME='WID_TEXT_3')

WIDGET_CONTROL, WID_TEXT_1,  get_value = UnsharpRadius
WIDGET_CONTROL, WID_TEXT_2,  get_value = ThreshVal
WIDGET_CONTROL, WID_TEXT_3,  get_value = KernelRadius

WID_BUTTON_20 = Widget_Info(Event.top, FIND_BY_UNAME='WID_BUTTON_20')
WIDGET_CONTROL, WID_BUTTON_20,  get_uvalue = data
WID_BUTTON_11 = Widget_Info(Event.top, FIND_BY_UNAME='WID_BUTTON_11')
WIDGET_CONTROL, WID_BUTTON_11,  get_uvalue = reference
WID_BUTTON_19 = Widget_Info(Event.top, FIND_BY_UNAME='WID_BUTTON_19')
RefStatus = Widget_Info(WID_BUTTON_19, /BUTTON_SET)
WID_BUTTON_22 = Widget_Info(Event.top, FIND_BY_UNAME='WID_BUTTON_22')
WIDGET_CONTROL, WID_BUTTON_22,  get_uvalue = mask
WID_TEXT_8 = Widget_Info(Event.top, FIND_BY_UNAME='WID_TEXT_8')
WIDGET_CONTROL, WID_TEXT_8,  get_value = MaxVal
MaxVal = fix(MaxVal(0))

IF RefStatus eq 1 THEN BEGIN
	measurement = (data - reference)*mask
	measurement = (measurement + abs(min(measurement)))*mask
ENDIF ELSE BEGIN
	measurement = (data + abs(min(data*mask)))*mask
ENDELSE

scaled = bytscl(measurement, MIN = 0, MAX = MaxVal)

unsharp = UNSHARP_MASK(scaled, RADIUS = fix(UnsharpRadius(0))) - scaled

; Define a structuring kernal for an opening operation on the image.
radius = fix(KernelRadius(0))
kernel = SHIFT(DIST(2*radius+1), radius, radius) LE radius

; Apply the opening operator to the image.
openImage = MORPH_OPEN(unsharp, kernel, /GRAY)

mask = openImage GE fix(ThreshVal(0))

WID_DRAW_0 = Widget_Info(Event.top, FIND_BY_UNAME='WID_DRAW_0')			;Draw widget address
WIDGET_CONTROL, WID_DRAW_0,  get_value = win_num
loadct, 13
wset, win_num
tvscl, mask
loadct, 0
end

;-----------------------------------------------------------------
; Activate Button Callback Procedure.
; Argument:
;-----------------------------------------------------------------
pro OnShowOverlay, Event

WID_TEXT_1 = Widget_Info(Event.top, FIND_BY_UNAME='WID_TEXT_1')
WID_TEXT_2 = Widget_Info(Event.top, FIND_BY_UNAME='WID_TEXT_2')
WID_TEXT_3 = Widget_Info(Event.top, FIND_BY_UNAME='WID_TEXT_3')

WIDGET_CONTROL, WID_TEXT_1,  get_value = UnsharpRadius
WIDGET_CONTROL, WID_TEXT_2,  get_value = ThreshVal
WIDGET_CONTROL, WID_TEXT_3,  get_value = KernelRadius

WID_BUTTON_20 = Widget_Info(Event.top, FIND_BY_UNAME='WID_BUTTON_20')
WIDGET_CONTROL, WID_BUTTON_20,  get_uvalue = data
WID_BUTTON_11 = Widget_Info(Event.top, FIND_BY_UNAME='WID_BUTTON_11')
WIDGET_CONTROL, WID_BUTTON_11,  get_uvalue = reference
WID_BUTTON_19 = Widget_Info(Event.top, FIND_BY_UNAME='WID_BUTTON_19')
RefStatus = Widget_Info(WID_BUTTON_19, /BUTTON_SET)
WID_BUTTON_22 = Widget_Info(Event.top, FIND_BY_UNAME='WID_BUTTON_22')
WIDGET_CONTROL, WID_BUTTON_22,  get_uvalue = mask
WID_TEXT_8 = Widget_Info(Event.top, FIND_BY_UNAME='WID_TEXT_8')
WIDGET_CONTROL, WID_TEXT_8,  get_value = MaxVal
MaxVal = fix(MaxVal(0))

IF RefStatus eq 1 THEN BEGIN
	measurement = (data - reference)*mask
	measurement = (measurement + abs(min(measurement)))*mask
ENDIF ELSE BEGIN
	measurement = (data + abs(min(data*mask)))*mask
ENDELSE

scaled = bytscl(measurement, MIN = 0, MAX = MaxVal)

unsharp = UNSHARP_MASK(scaled, RADIUS = fix(UnsharpRadius(0))) - scaled

; Define a structuring kernal for an opening operation on the image.
radius = fix(KernelRadius(0))
kernel = SHIFT(DIST(2*radius+1), radius, radius) LE radius

; Apply the opening operator to the image.
openImage = MORPH_OPEN(unsharp, kernel, /GRAY)

blobmask = openImage GE fix(ThreshVal(0))

IF max(blobmask) gt min(blobmask) THEN BEGIN
	; Do the analysis.
	blobs = Obj_New('blob_analyzer', openImage, MASK=blobmask, SCALE=[1, 1])

	; Display the original image
	s = Size(data, /DIMENSIONS)
	;Window, XSIZE=2*s[0], YSIZE=2*s[1], Title='Blob Analyzer'
	count = blobs -> NumberOfBlobs()

	WID_DRAW_0 = Widget_Info(Event.top, FIND_BY_UNAME='WID_DRAW_0')			;Draw widget address
	WIDGET_CONTROL, WID_DRAW_0,  get_value = win_num
	wset, win_num
	;loadct 0

	; Display the original image, with blob outlined and labelled.
	TVImage, scaled, /TV

	FOR j=0,count-1 DO BEGIN
  		stats = blobs -> GetStats(j, /NoScale)
  		PLOTS, stats.perimeter_pts[0,*], stats.perimeter_pts[1,*], /Device, COLOR=FSC_Color('Dodger Blue');,/NORMAL
  		XYOUTS, stats.center[0]-10, stats.center[1]-5, /Device, StrTrim(j,2), $
      		COLOR=FSC_Color('Red'), ALIGNMENT=0.5, CHARSIZE=0.75
	ENDFOR
	; Destroy the object.
	Obj_Destroy, blobs
ENDIF ELSE BEGIN
	WID_DRAW_0 = Widget_Info(Event.top, FIND_BY_UNAME='WID_DRAW_0')			;Draw widget address
	WIDGET_CONTROL, WID_DRAW_0,  get_value = win_num
	wset, win_num
	;loadct 0

	; Display the original image, with blob outlined and labelled.
	;TVImage, scaled, /TV
	tvscl, scaled
ENDELSE
end

;-----------------------------------------------------------------
; Activate Button Callback Procedure.
; Argument:
;-----------------------------------------------------------------
pro OnShowAll, Event

WID_TEXT_1 = Widget_Info(Event.top, FIND_BY_UNAME='WID_TEXT_1')
WID_TEXT_2 = Widget_Info(Event.top, FIND_BY_UNAME='WID_TEXT_2')
WID_TEXT_3 = Widget_Info(Event.top, FIND_BY_UNAME='WID_TEXT_3')

WIDGET_CONTROL, WID_TEXT_1,  get_value = UnsharpRadius
WIDGET_CONTROL, WID_TEXT_2,  get_value = ThreshVal
WIDGET_CONTROL, WID_TEXT_3,  get_value = KernelRadius

WID_BUTTON_20 = Widget_Info(Event.top, FIND_BY_UNAME='WID_BUTTON_20')
WIDGET_CONTROL, WID_BUTTON_20,  get_uvalue = data
WID_BUTTON_11 = Widget_Info(Event.top, FIND_BY_UNAME='WID_BUTTON_11')
WIDGET_CONTROL, WID_BUTTON_11,  get_uvalue = reference
WID_BUTTON_19 = Widget_Info(Event.top, FIND_BY_UNAME='WID_BUTTON_19')
RefStatus = Widget_Info(WID_BUTTON_19, /BUTTON_SET)
WID_BUTTON_22 = Widget_Info(Event.top, FIND_BY_UNAME='WID_BUTTON_22')
WIDGET_CONTROL, WID_BUTTON_22,  get_uvalue = mask
WID_TEXT_8 = Widget_Info(Event.top, FIND_BY_UNAME='WID_TEXT_8')
WIDGET_CONTROL, WID_TEXT_8,  get_value = MaxVal
MaxVal = fix(MaxVal(0))

IF RefStatus eq 1 THEN BEGIN
	measurement = (data - reference)*mask
	measurement = (measurement + abs(min(measurement)))*mask
ENDIF ELSE BEGIN
	measurement = (data + abs(min(data*mask)))*mask
ENDELSE

scaled = bytscl(measurement, MIN = 0, MAX = MaxVal)

unsharp = UNSHARP_MASK(scaled, RADIUS = fix(UnsharpRadius(0))) - scaled

; Define a structuring kernal for an opening operation on the image.
radius = fix(KernelRadius(0))
kernel = SHIFT(DIST(2*radius+1), radius, radius) LE radius

; Apply the opening operator to the image.
openImage = MORPH_OPEN(unsharp, kernel, /GRAY)

blobmask = openImage GE fix(ThreshVal(0))

blobmask = congrid(blobmask,500,500)
openImage = congrid(openImage,500,500)
unsharp = congrid(unsharp,500,500)
scaled = congrid(scaled,500,500)
measurement = congrid(measurement,500,500)

; Display the original image
s = Size(measurement, /DIMENSIONS)
Window, XSIZE=2*s[0], YSIZE=2*s[1], Title='Blob Analyzer'
loadct, 0
TVImage, scaled, 0, /TV
TVImage, unsharp, 1, /TV
TVImage, bytscl(blobmask), 2, /TV
TVImage, scaled, 3, /TV

;TVscl, scaled, 0, /TV
;TVscl, unsharp, 1, /TV
;TVscl, blobmask, 2, /TV
;TVscl, scaled, 3, /TV

IF max(blobmask) gt min(blobmask) THEN BEGIN
	; Do the analysis.
	blobs = Obj_New('blob_analyzer', openImage, MASK=blobmask, SCALE=[1, 1])
	count = blobs -> NumberOfBlobs()

	FOR j=0,count-1 DO BEGIN
  		stats = blobs -> GetStats(j, /NoScale)
  		PLOTS, stats.perimeter_pts[0,*] + s[0], stats.perimeter_pts[1,*], /Device, COLOR=FSC_Color('Dodger Blue');,/NORMAL
  		XYOUTS, stats.center[0]+s[0]-5, stats.center[1]-2.5, /Device, StrTrim(j,2), $
      		COLOR=FSC_Color('Red'), ALIGNMENT=0.5, CHARSIZE=0.55
	ENDFOR

	XYOUTS, .03, .92, 'Original Image', FONT=0, ALIGNMENT=0, COLOR=FSC_Color('Yellow'), /NORMAL
	XYOUTS, .55, .92, 'Enhanced', FONT=0, ALIGNMENT=0, COLOR=FSC_Color('Yellow'), /NORMAL
    XYOUTS, .03, .45, 'Blobs Only', FONT=0, ALIGNMENT=0, COLOR=FSC_Color('Yellow'), /NORMAL
	XYOUTS, .55, .45, 'Blobs Overlay', FONT=0, ALIGNMENT=0, COLOR=FSC_Color('Yellow'), /NORMAL

	; Report stats.
	;blobs -> ReportStats
	; Destroy the object.
	Obj_Destroy, blobs

ENDIF ELSE BEGIN
	XYOUTS, .03, .92, 'Original Image', FONT=0, ALIGNMENT=0, COLOR=FSC_Color('Yellow'), /NORMAL
	XYOUTS, .55, .92, 'Enhanced', FONT=0, ALIGNMENT=0, COLOR=FSC_Color('Yellow'), /NORMAL
    XYOUTS, .03, .45, 'No Blobs', FONT=0, ALIGNMENT=0, COLOR=FSC_Color('Yellow'), /NORMAL
	XYOUTS, .55, .45, 'Blobs Overlay', FONT=0, ALIGNMENT=0, COLOR=FSC_Color('Yellow'), /NORMAL
ENDELSE

WID_TEXT_24 = Widget_Info(Event.top, FIND_BY_UNAME='WID_TEXT_24')
WIDGET_CONTROL, WID_TEXT_24,  get_value = val
val=fix(val(0))
WID_BUTTON_21 = Widget_Info(Event.top, FIND_BY_UNAME='WID_BUTTON_21')
WIDGET_CONTROL, WID_BUTTON_21,  get_uvalue = FileList
filename = FileList(val-1)

XYOUTS, .50, .98, filename, FONT=0, ALIGNMENT=0.5, COLOR=FSC_Color('Red'), /NORMAL
IF refstatus eq 1 THEN BEGIN
	XYOUTS, .50, .96, 'Reference Subtracted', FONT=0, ALIGNMENT=0.5, COLOR=FSC_Color('Red'),/NORMAL
ENDIF
end

;-----------------------------------------------------------------
; Activate Button Callback Procedure.
; Argument:
;-----------------------------------------------------------------
pro OnAnalyzePreview, Event

WID_TEXT_1 = Widget_Info(Event.top, FIND_BY_UNAME='WID_TEXT_1')
WID_TEXT_2 = Widget_Info(Event.top, FIND_BY_UNAME='WID_TEXT_2')
WID_TEXT_3 = Widget_Info(Event.top, FIND_BY_UNAME='WID_TEXT_3')

WIDGET_CONTROL, WID_TEXT_1,  get_value = UnsharpRadius
WIDGET_CONTROL, WID_TEXT_2,  get_value = ThreshVal
WIDGET_CONTROL, WID_TEXT_3,  get_value = KernelRadius

WID_BUTTON_20 = Widget_Info(Event.top, FIND_BY_UNAME='WID_BUTTON_20')
WIDGET_CONTROL, WID_BUTTON_20,  get_uvalue = data
WID_BUTTON_11 = Widget_Info(Event.top, FIND_BY_UNAME='WID_BUTTON_11')
WIDGET_CONTROL, WID_BUTTON_11,  get_uvalue = reference
WID_BUTTON_19 = Widget_Info(Event.top, FIND_BY_UNAME='WID_BUTTON_19')
RefStatus = Widget_Info(WID_BUTTON_19, /BUTTON_SET)
WID_BUTTON_22 = Widget_Info(Event.top, FIND_BY_UNAME='WID_BUTTON_22')
WIDGET_CONTROL, WID_BUTTON_22,  get_uvalue = mask
WID_TEXT_8 = Widget_Info(Event.top, FIND_BY_UNAME='WID_TEXT_8')
WIDGET_CONTROL, WID_TEXT_8,  get_value = MaxVal
MaxVal = fix(MaxVal(0))

IF RefStatus eq 1 THEN BEGIN
	measurement = (data - reference)*mask
	measurement = (measurement + abs(min(measurement)))*mask
ENDIF ELSE BEGIN
	measurement = (data + abs(min(data*mask)))*mask
ENDELSE

scaled = bytscl(measurement, MIN = 0, MAX = MaxVal)
unsharp = UNSHARP_MASK(scaled, RADIUS = fix(UnsharpRadius(0))) - scaled

; Define a structuring kernal for an opening operation on the image.
radius = fix(KernelRadius(0))
kernel = SHIFT(DIST(2*radius+1), radius, radius) LE radius

; Apply the opening operator to the image.
openImage = MORPH_OPEN(unsharp, kernel, /GRAY)
blobmask = openImage GE fix(ThreshVal(0))


WID_TEXT_5 = Widget_Info(Event.top, FIND_BY_UNAME='WID_TEXT_5')
WIDGET_CONTROL, WID_TEXT_5,  get_value = MinBin
MinBin = fix(MinBin(0))

WID_TEXT_11 = Widget_Info(Event.top, FIND_BY_UNAME='WID_TEXT_11')
WIDGET_CONTROL, WID_TEXT_11,  get_value = MaxBin
MaxBin = fix(MaxBin(0))

WID_TEXT_12 = Widget_Info(Event.top, FIND_BY_UNAME='WID_TEXT_12')
WIDGET_CONTROL, WID_TEXT_12,  get_value = NumBins
NumBins = fix(NumBins(0))

;---------------------------------------------------------------------------------------------------
; The following section analyzes some of the blob data.  It creates DataArray, which includes
; the X,Y coordinates and pixel area for each blob identified.  This can be exported to a text file
; for later analysis.  Also creates an array of the average blob area for each measurement.
;---------------------------------------------------------------------------------------------------
DataArray = MAKE_ARRAY(4,1)
; Set Columns, allows user to reorder or add columns without changing indices everywhere in program
IndexCol = 0
CenterXCol = 1
CenterYCol = 2
AreaCol = 3

IF max(blobmask) gt min(blobmask) THEN BEGIN   ;Makes sure there are actually blobs

	; Do the analysis.
	blobs = Obj_New('blob_analyzer', openImage, MASK=blobmask, SCALE=[1, 1])
	count = blobs -> NumberOfBlobs()
	;count = blobs.NumberOfBlobs

	; This FOR loop pulls info about each blob within a given data set.  Needs to run on each new measurement file
	DataArray = MAKE_ARRAY(4,count) ; #of stats wide, #of blobs tall
	j = 0
	IF (count GT 1) THEN BEGIN
		FOR j=0, count - 1 DO BEGIN
			stats = blobs -> GetStats(j, /NoScale)
			DataArray(IndexCol,j) = j
			DataArray(CenterXCol,j) = stats.CENTER[0]
			DataArray(CenterYCol,j) = stats.CENTER[1]
			DataArray(AreaCol,j) = stats.PIXEL_AREA
		ENDFOR

		;---------------------------------------------------------------------------------------------------
		; Create a histogram of blob area distributions in each measurement.  The bin characteristics are
		; set before this loop begins.  The number of bins should be roughly equal to the root of the number of
		; blobs.  It is convenient to use the same bin characteristics for each measurement set in order to graphically
		; compare them at a later time, so the number of bins is currently set based on typical values I've found.
		;---------------------------------------------------------------------------------------------------
		Hist = Histogram(DataArray(AreaCol,*), MIN = MinBin, MAX = MaxBin, NBINS = NumBins)

		;---------------------------------------------------------------------------------------------------
		; This portion uses the Distance_Measure function to measure distances between the blob positions
		; found in the DataArray.  Two are created: a shortform vector along with a symmetric matrix. The vector
		; version is used to calculate the average distance between all points.  IE, average between blob 1-1, 1-2,
		; 1-n and so on.  The matrix is used to determine distances to nearest blobs.
		;---------------------------------------------------------------------------------------------------
		s = SIZE(DataArray)

		Distance = DISTANCE_MEASURE(DataArray([CenterXCol,CenterYCol],*))
		DistanceMatrix = DISTANCE_MEASURE(DataArray([CenterXCol,CenterYCol],*), /MATRIX)
		ZeroIndex = where(DistanceMatrix eq 0)
		DistanceMatrix(ZeroIndex) = 99999
		MatrixSize = SIZE(DistanceMatrix)
		j = 0
		MinValues = MAKE_ARRAY(MatrixSize(1))
		MinPositions = MAKE_ARRAY(MatrixSize(1))

		FOR j=0,MatrixSize(1)-1 DO BEGIN
			MinValues(j) = MIN(DistanceMatrix(*,j))
			MinPositions(j) = WHERE(DistanceMatrix(*,j) EQ MIN(DistanceMatrix(*,j)))
		ENDFOR
	;AverageDistance = MEAN(Distance)
	;AverageMinDistance = MEAN(MinValues)
	ENDIF ELSE BEGIN
		stats = blobs -> GetStats(0, /NoScale)
		DataArray(IndexCol,0) = 0
		DataArray(CenterXCol,0) = stats.CENTER[0]
		DataArray(CenterYCol,0) = stats.CENTER[1]
		DataArray(AreaCol,0) = stats.PIXEL_AREA
		Distance = 0
		MinValues = 0
		Hist = Make_Array(NumBins,1)
	ENDELSE

	; Destroy the object.
	Obj_Destroy, blobs
ENDIF ELSE BEGIN
	count = 0
	Distance = 0
	MinValues = 0
	Hist = Make_Array(NumBins,1)
ENDELSE
Print, DataArray(AreaCol,0)
AverageArea = MEAN(DataArray(AreaCol,*))
AverageDistance = MEAN(Distance)
AverageMinDistance = MEAN(MinValues)

WID_TEXT_14 = Widget_Info(Event.top, FIND_BY_UNAME='WID_TEXT_14')
WIDGET_CONTROL, WID_TEXT_14,  set_value = strtrim(string(AverageDistance),2)

WID_TEXT_15 = Widget_Info(Event.top, FIND_BY_UNAME='WID_TEXT_15')
WIDGET_CONTROL, WID_TEXT_15,  set_value = strtrim(string(AverageMinDistance),2)

WID_TEXT_16 = Widget_Info(Event.top, FIND_BY_UNAME='WID_TEXT_16')
WIDGET_CONTROL, WID_TEXT_16,  set_value = strtrim(string(AverageArea),2)

WID_TEXT_27 = Widget_Info(Event.top, FIND_BY_UNAME='WID_TEXT_27')
WIDGET_CONTROL, WID_TEXT_27,  set_value = string(count)

WID_DRAW_1 = Widget_Info(Event.top, FIND_BY_UNAME='WID_DRAW_1')			;Draw widget address
WIDGET_CONTROL, WID_DRAW_1,  get_value = win_num
wset, win_num
plot, Hist

end

;-----------------------------------------------------------------
; Activate Button Callback Procedure.
; Argument:
;-----------------------------------------------------------------
pro RunFullAnalysis, Event

WID_TEXT_1 = Widget_Info(Event.top, FIND_BY_UNAME='WID_TEXT_1')
WID_TEXT_2 = Widget_Info(Event.top, FIND_BY_UNAME='WID_TEXT_2')
WID_TEXT_3 = Widget_Info(Event.top, FIND_BY_UNAME='WID_TEXT_3')

WIDGET_CONTROL, WID_TEXT_1,  get_value = UnsharpRadius
WIDGET_CONTROL, WID_TEXT_2,  get_value = ThreshVal
WIDGET_CONTROL, WID_TEXT_3,  get_value = KernelRadius

WID_BUTTON_11 = Widget_Info(Event.top, FIND_BY_UNAME='WID_BUTTON_11')
WIDGET_CONTROL, WID_BUTTON_11,  get_uvalue = reference
WID_BUTTON_19 = Widget_Info(Event.top, FIND_BY_UNAME='WID_BUTTON_19')
RefStatus = Widget_Info(WID_BUTTON_19, /BUTTON_SET)
WID_BUTTON_22 = Widget_Info(Event.top, FIND_BY_UNAME='WID_BUTTON_22')
WIDGET_CONTROL, WID_BUTTON_22,  get_uvalue = mask
WID_TEXT_8 = Widget_Info(Event.top, FIND_BY_UNAME='WID_TEXT_8')
WIDGET_CONTROL, WID_TEXT_8,  get_value = MaxVal
MaxVal = fix(MaxVal(0))
WID_TEXT_17 = Widget_Info(Event.top, FIND_BY_UNAME='WID_TEXT_17')
WIDGET_CONTROL, WID_TEXT_17, get_value = Increment
Increment = fix(Increment(0))
WID_BUTTON_10 = Widget_Info(Event.top, FIND_BY_UNAME='WID_BUTTON_10')
ScaleStatus = Widget_Info(WID_BUTTON_10, /BUTTON_SET)
WID_BUTTON_21 = Widget_Info(Event.top, FIND_BY_UNAME='WID_BUTTON_21')
WIDGET_CONTROL, WID_BUTTON_21,  get_uvalue = FileList

NumFiles = N_ELEMENTS(FileList)
NumAnalyzed = NumFiles/Increment

;Set Up Histogram Parameters for later use
WID_TEXT_5 = Widget_Info(Event.top, FIND_BY_UNAME='WID_TEXT_5')
WIDGET_CONTROL, WID_TEXT_5,  get_value = MinBin
MinBin = fix(MinBin(0))

WID_TEXT_11 = Widget_Info(Event.top, FIND_BY_UNAME='WID_TEXT_11')
WIDGET_CONTROL, WID_TEXT_11,  get_value = MaxBin
MaxBin = fix(MaxBin(0))

WID_TEXT_12 = Widget_Info(Event.top, FIND_BY_UNAME='WID_TEXT_12')
WIDGET_CONTROL, WID_TEXT_12,  get_value = NumBins
NumBins = fix(NumBins(0))

; Set up blank arrays for storing data within the loop
Hist = MAKE_ARRAY(NumBins,NumAnalyzed+1)
AverageArea = MAKE_ARRAY(NumAnalyzed+1)
AverageDistance = MAKE_ARRAY(NumAnalyzed+1)
AverageMinDistance = MAKE_ARRAY(NumAnalyzed+1)
CountArray = MAKE_ARRAY(NumAnalyzed+1)

; Initialize count.  Use k, rather than loop variables due to incrimenting.  "i" will go up by increment,
; and there are only "k" elements in each vector
k = 0

; First FOR loop runs included analysis on each measurement set selected, taking increment into consideration
FOR i=0,NumFiles-1, Increment DO BEGIN

	WID_TEXT_9 = Widget_Info(Event.top, FIND_BY_UNAME='WID_TEXT_9')
	;WIDGET_CONTROL, WID_TEXT_9,  set_value = strtrim(string(k+1),2)
	str = 'Processing'+strcompress(string(k+1))+' of'+strcompress(string(NumAnalyzed))
    WIDGET_CONTROL, WID_TEXT_9, set_value = str
	;WID_TEXT_10 = Widget_Info(Event.top, FIND_BY_UNAME='WID_TEXT_10')
	;WIDGET_CONTROL, WID_TEXT_10,  set_value = strtrim(string(NumAnalyzed),2)
	;--------------------------------------------------------------------------------------------------
	; This portion of the code imports the file and does appropriate filtering to create bi-level image
	; to be passed to blob analysis.  User can modify bytscl valuesif needed, along with unsharp_mask
	; kernel size.  Can also modify radius for structuring kernel, along with mask threshold.
	;--------------------------------------------------------------------------------------------------
	data = readtext(FileList(i))

	IF ScaleStatus eq 1 THEN data=-data

	IF RefStatus eq 1 THEN BEGIN
		measurement = (data - reference)*mask
		measurement = (measurement + abs(min(measurement)))*mask
		scaled = bytscl(measurement, MIN = 0, MAX = MaxVal)
	ENDIF ELSE BEGIN
		measurement = (data + abs(min(data*mask)))*mask
		scaled = bytscl(measurement, MIN=0, MAX = MaxVal)
	ENDELSE

	unsharp = UNSHARP_MASK(scaled, RADIUS = fix(UnsharpRadius(0))) - scaled

	; Define a structuring kernal for an opening operation on the image.
	radius = fix(KernelRadius(0))
	kernel = SHIFT(DIST(2*radius+1), radius, radius) LE radius

	; Apply the opening operator to the image.
	openImage = MORPH_OPEN(unsharp, kernel, /GRAY)
	blobmask = openImage GE fix(ThreshVal(0))

	;Set up blan data array to fill with blob info
	DataArray = MAKE_ARRAY(4,1)
		; Set Columns, allows user to reorder or add columns without changing indices everywhere in program
	IndexCol = 0
	CenterXCol = 1
	CenterYCol = 2
	AreaCol = 3

	IF max(blobmask) gt min(blobmask) THEN BEGIN

		; Call the blob analysis
		blobs = Obj_New('blob_analyzer', openImage, MASK=blobmask, SCALE=[1, 1])
		count = blobs -> NumberOfBlobs()

		;---------------------------------------------------------------------------------------------------
		; The following section analyzes some of the blob data.  It creates DataArray, which includes
		; the X,Y coordinates and pixel area for each blob identified.  This can be exported to a text file
		; for later analysis.  Also creates an array of the average blob area for each measurement.
		;---------------------------------------------------------------------------------------------------
		DataArray = MAKE_ARRAY(4,count) ; #of stats wide, #of blobs tall
		; This FOR loop pulls info about each blob within a given data set.  Needs to run on each new measurement file
		j = 0
		FOR j=0, count - 1 DO BEGIN
			stats = blobs -> GetStats(j, /NoScale)
			DataArray(IndexCol,j) = j
			DataArray(CenterXCol,j) = stats.CENTER[0]
			DataArray(CenterYCol,j) = stats.CENTER[1]
			DataArray(AreaCol,j) = stats.PIXEL_AREA
		ENDFOR

		;---------------------------------------------------------------------------------------------------
		; Create a histogram of blob area distributions in each measurement.  The bin characteristics are
		; set before this loop begins.  The number of bins should be roughly equal to the root of the number of
		; blobs.  It is convenient to use the same bin characteristics for each measurement set in order to graphically
		; compare them at a later time, so the number of bins is currently set based on typical values I've found.
		;---------------------------------------------------------------------------------------------------
		Hist(*,k) = Histogram(DataArray(AreaCol,*), MIN = MinBin, MAX = MaxBin, NBINS = NumBins)

		;---------------------------------------------------------------------------------------------------
		; This portion uses the Distance_Measure function to measure distances between the blob positions
		; found in the DataArray.  Two are created: a shortform vector along with a symmetric matrix. The vector
		; version is used to calculate the average distance between all points.  IE, average between blob 1-1, 1-2,
		; 1-n and so on.  The matrix is used to determine distances to nearest blobs.
		;---------------------------------------------------------------------------------------------------
		s = SIZE(DataArray)

;Window, XSIZE=2*s[0], YSIZE=2*s[1], Title='Blob Analyzer Example'
;LoadCT, 0
;TVscl, data
		If s(0) gt 1 THEN BEGIN
			Distance = DISTANCE_MEASURE(DataArray([CenterXCol,CenterYCol],*))
			DistanceMatrix = DISTANCE_MEASURE(DataArray([CenterXCol,CenterYCol],*), /MATRIX)
			ZeroIndex = where(DistanceMatrix eq 0)
			DistanceMatrix(ZeroIndex) = 99999
			MatrixSize = SIZE(DistanceMatrix)
			j = 0
			MinValues = MAKE_ARRAY(MatrixSize(1))
			MinPositions = MAKE_ARRAY(MatrixSize(1))

			FOR j=0,MatrixSize(1)-1 DO BEGIN
				MinValues(j) = MIN(DistanceMatrix(*,j))
				MinPos = WHERE(DistanceMatrix(*,j) EQ MIN(DistanceMatrix(*,j)))
				MinPositions(j) = MinPos(0)
			ENDFOR
		ENDIF ELSE BEGIN
			MinValues = 0
			Distance = 0
		ENDELSE

		; Destroy the blobs object before repeating the loop.
		Obj_Destroy, blobs
	ENDIF ELSE BEGIN
		count = 0
		Distance = 0
		MinValues = 0
		Hist(*,k) = Make_Array(NumBins,1)
	ENDELSE

	AverageArea(k) = MEAN(DataArray(AreaCol,*))
	AverageDistance(k) = MEAN(Distance)
	AverageMinDistance(k) = MEAN(MinValues)
	CountArray(k) = count

	k = k+1

ENDFOR

;---------------------------------------------------------------------------------------------------
; This section reformats the array for export into a user selected .dat file.
; First we'll export the averages and then the histograms
;---------------------------------------------------------------------------------------------------

ExportArray = MAKE_ARRAY(5,NumAnalyzed+1)
ExportArray(0,*) = INDGEN(NumAnalyzed+1)+1
ExportArray(1,*) = AverageArea
ExportArray(2,*) = AverageDistance
ExportArray(3,*) = AverageMinDistance
ExportArray(4,*) = CountArray

WID_BUTTON_12 = Widget_Info(Event.top, FIND_BY_UNAME='WID_BUTTON_12')
WIDGET_CONTROL, WID_BUTTON_12,  set_uvalue = ExportArray

ExportArray = [(indgen(1,NumAnalyzed+1)),hist]
ExportArray = [[indgen(NumBins+1,1)],[ExportArray]]

WID_BUTTON_13 = Widget_Info(Event.top, FIND_BY_UNAME='WID_BUTTON_13')
WIDGET_CONTROL, WID_BUTTON_13,  set_uvalue = ExportArray

WID_DRAW_2 = Widget_Info(Event.top, FIND_BY_UNAME='WID_DRAW_2')			;Draw widget address
WIDGET_CONTROL, WID_DRAW_2,  get_value = win_num
wset, win_num
AverageArea = shift(AverageArea, 1)
!X.Margin=[4,2]
!Y.Margin=[2,2]
plot, AverageArea, Title='Average Area'

WID_DRAW_3 = Widget_Info(Event.top, FIND_BY_UNAME='WID_DRAW_3')			;Draw widget address
WIDGET_CONTROL, WID_DRAW_3,  get_value = win_num
wset, win_num
AverageDistance = shift(AverageDistance, 1)
plot, AverageDistance, Title='Average Distance'

WID_DRAW_4 = Widget_Info(Event.top, FIND_BY_UNAME='WID_DRAW_4')			;Draw widget address
WIDGET_CONTROL, WID_DRAW_4,  get_value = win_num
wset, win_num
AverageMinDistance = shift(AverageMinDistance, 1)
plot, AverageMinDistance, Title='Average Min Distance'

WID_DRAW_7 = Widget_Info(Event.top, FIND_BY_UNAME='WID_DRAW_7')			;Draw widget address
WIDGET_CONTROL, WID_DRAW_7,  get_value = win_num
wset, win_num
CountArray = shift(CountArray, 1)
plot, CountArray, Title='Count'

end
;-----------------------------------------------------------------
; Activate Button Callback Procedure.
; Argument:
;-----------------------------------------------------------------
pro SaveAverage, Event

WID_BUTTON_12 = Widget_Info(Event.top, FIND_BY_UNAME='WID_BUTTON_12')
WIDGET_CONTROL, WID_BUTTON_12,  get_uvalue = ExportArray

header = '      File#        AvgArea      AvgSpacing   AvgMinDistance     Count'

;CD, 'C:\'
filename = DIALOG_PICKFILE(DEFAULT_EXTENSION = 'dat', /OVERWRITE_PROMPT, $
	TITLE = 'Select File to Averages, or Type in New Name')

OPENW, 1, filename, WIDTH = 250
PRINTF, 1, header
PRINTF, 1, ExportArray
CLOSE, 1

end
;-----------------------------------------------------------------
; Activate Button Callback Procedure.
; Argument:
;-----------------------------------------------------------------
pro SaveHistogram, Event

WID_BUTTON_13 = Widget_Info(Event.top, FIND_BY_UNAME='WID_BUTTON_13')
WIDGET_CONTROL, WID_BUTTON_13,  get_uvalue = ExportArray

;CD, 'C:\'
header = '       File#       Bin Numbers (Horizontal)'
filename = DIALOG_PICKFILE(DEFAULT_EXTENSION = 'dat', /OVERWRITE_PROMPT, $
	TITLE = 'Select File to Histogram, or Type in New Name')

OPENW, 1, filename, WIDTH = 1000
PRINTF, 1, header
PRINTF, 1, ExportArray
CLOSE, 1

end
;
; Empty stub procedure used for autoloading.
;
pro BlobAnalysisGUI_eventcb
end