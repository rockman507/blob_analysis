; readtext		John Crocker & David Grier
;
;	This function reads in arbitrary size ascii data files
;	into an array 'res'. Files must be 'rectangular'.
;	Use head to return the first line (header) of the file.
;	This line must be less than 255 characters long!
;
;   See:  http://www.physics.emory.edu/~weeks/idl/
;   for more information.
;
;	Can use the same algorithms to convert arrays of bytes
;	directly with 'chararr' keyword
;
function readtext,filename,mas,head,quiet = quiet,carr = carr, int=int
; /int to read in integer data, default assumes floating point
; /quiet to stop printing a message


f = findfile(filename)
if f(0) eq '' then message,'No match!'

;get file names
data_file = filename
temp = STRSPLIT(data_file, '\', /EXTRACT)
temp = temp[0:size(temp, /dimensions)-2]
temp[size(temp, /dimensions)-1] = 'debug.csv'
debug_file = STRJOIN(temp, '\')
temp[size(temp, /dimensions)-1] = 'mask.dat'
mask_file = STRJOIN(temp, '\')

;debug
;print, 'data file: ',data_file
;print, 'mask file: ',mask_file
;print, 'debug file: ',debug_file

;get x and y size of arrays
openr, lun, debug_file, /get_lun
temp_read = ''
readf, lun, temp_read
temp = STRSPLIT(temp_read, ',', /EXTRACT)
x_size = temp[1]
readf, lun, temp_read
temp = STRSPLIT(temp_read, ',', /EXTRACT)
y_size = temp[1]
free_lun, lun

;debug
;print, 'X size is ', x_size
;print, 'Y size is ', y_size

;get waveform
data = fltarr(x_size,y_size)
openr, lun, data_file, /get_lun
readu, lun, data
free_lun, lun

;get mask
mask = bytarr(x_size,y_size)
openr, lun, mask_file, /get_lun
readu, lun, mask
free_lun, lun

;debug
;help, data, mask
;print, data[200,200], mask[200,200]
;print, data[1,1], mask[1,1]

;apply mask
index = where(mask eq 0)
data[index] = 0.0

;build 1000x1000 array where 90000 is masked
res = replicate(0.0,1000,1000)
res[500-(x_size/2):500+(x_size/2)-1,500-(y_size/2):500+(y_size/2)-1] = data
mas = replicate(0.0,1000,1000)
mas[500-(x_size/2):500+(x_size/2)-1,500-(y_size/2):500+(y_size/2)-1] = mask


;Determine the size of the wavefront
res = reverse(res,2)
mas = reverse(mas,2)
;size_wavefront_x = (size(res))[1]
;size_wavefront_y = (size(res))[2]
;first_x = 0
;last_x = size_wavefront_x-1
;size_x = size_wavefront_x
;first_y = 0
;last_y = size_wavefront_y-1
;size_y = size_wavefront_y

; find the non-zero region
;non_zero = where(res lt res[0], count)
;if (count gt 1) then begin
;	;Find y limits
;	;Find first and last non-zero array points
;	first = non_zero[0]
;	last = non_zero[((size(non_zero))[1])-1]
;
;	;Find the y positions of first and last
;	first_y = first/size_wavefront_x
;	last_y = last/size_wavefront_x
;	size_y = last_y - first_y + 1
;
;	;Find x limits
;	;Find first and last non-zero array points
;	non_zero = where(rotate(res,1) lt res[0])
;	first = non_zero[0]
;	last = non_zero[((size(non_zero))[1])-1]
;
;	;Find the x positions of first and last
;	first_x = first/size_wavefront_y
;	last_x = last/size_wavefront_y
;	size_x = last_x - first_x + 1
;endif else begin ; no valid points set image to 2X2
;	first_x = 0
;	last_x = 1
;	size_x = 2
;
;	first_y = 0
;	last_y = 1
;	size_y = 2
;endelse

;res = res[first_x:last_x,first_y:last_y]

return,res
end



