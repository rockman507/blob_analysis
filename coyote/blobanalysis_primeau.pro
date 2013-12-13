pro blobanalysis_primeau


;Select File
;filename = dialog_pickfile()

;raw_data = readtext(filename)


; Get a file for analysis.
file = FILEPATH('r_seeberi.jpg', SUBDIRECTORY = ['examples', 'data'])
READ_JPEG, file, image, /GRAYSCALE
; Define a structuring kernal for an opening operation on the image.
radius = 5
kernel = SHIFT(DIST(2*radius+1), radius, radius) LE radius

; Apply the opening operator to the image.
openImage = MORPH_OPEN(image, kernel, /GRAY)

; Threshold the image to prepare to remove background noise.
; Notice that changing this value can produce more or less
; artifacts. You will have to decide what you can live with
; in your analysis. It requires some judgement on your part.
mask = openImage GE 150

; Do the analysis.
blobs = Obj_New('blob_analyzer', openImage, MASK=mask, SCALE=[0.5, 0.5])

; Display the original image
s = Size(image, /DIMENSIONS)
Window, XSIZE=2*s[0], YSIZE=2*s[1], Title='Blob Analyzer Example'
LoadCT, 0
TVImage, image, 0, /TV

; Display the opened image beside it.
TVImage, openImage, 1, /TV

; Display the blobs we located with LABEL_REGION.
count = blobs -> NumberOfBlobs()
blank = BytArr(s[0], s[1])
FOR j=0,count-1 DO BEGIN
  blobIndices = blobs -> GetIndices(j)
  blank[blobIndices] = image[blobIndices]
ENDFOR
TVImage, blank, 2, /TV

; Display the original image, with blob outlined and labelled.
TVImage, image, 3, /TV
FOR j=0,count-1 DO BEGIN
  stats = blobs -> GetStats(j, /NoScale)
  PLOTS, stats.perimeter_pts[0,*] + s[0], stats.perimeter_pts[1,*], /Device, COLOR=FSC_Color('dodger blue')
  XYOUTS, stats.center[0]+s[0], stats.center[1]-5, /Device, StrTrim(j,2), $
      COLOR=FSC_Color('red'), ALIGNMENT=0.5, CHARSIZE=0.75
ENDFOR

; Add labels for captions.
XYOUTS, 0.05, 0.95, 'A', FONT=0, ALIGNMENT=0.5, COLOR=FSC_Color('Yellow')
XYOUTS, 0.55, 0.95, 'B', FONT=0, ALIGNMENT=0.5, COLOR=FSC_Color('Yellow')
XYOUTS, 0.05, 0.45, 'C', FONT=0, ALIGNMENT=0.5, COLOR=FSC_Color('Yellow')
XYOUTS, 0.55, 0.45, 'D', FONT=0, ALIGNMENT=0.5, COLOR=FSC_Color('Yellow')

; Report stats.
blobs -> ReportStats

; Destroy the object.
Obj_Destroy, blobs

END