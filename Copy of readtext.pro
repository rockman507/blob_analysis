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
function readtext,filename,head,quiet = quiet,carr = carr, int=int
; /int to read in integer data, default assumes floating point
; /quiet to stop printing a message

if keyword_set( carr ) then begin
	a = carr
	size = n_elements( carr )

endif else begin
	f = findfile(filename)
	if f(0) eq '' then message,'No match!'

	openr,1,filename
	tmp = FSTAT(1)
	if (tmp.size gt 0) then begin
		a = bytarr(tmp.size)
		size = tmp.size
		readu,1,a
	endif else begin
		a=0b
	endelse
	close,1
endelse

linedel = ( (a eq 13B) or (a eq 10B) )			;CR or LF
worddel = ( (a eq 32B) or (a eq 9B) or (a eq 44B) or $
		 (a eq 124B) )	;SP or TAB or ','or '|'

if n_params() eq 2 then begin
	w = where( linedel(0:(size-1)<255),nl )
	if nl lt 1 then message,'No header found'
	head = string(a(0:w(0)-1))
	a = a(w(0)+1:*)
	linedel = linedel(w(0)+1:*)
	worddel = worddel(w(0)+1:*)
	size = size - w(0) - 1
endif

data = ( linedel or worddel ) eq 0

w = [ where( (linedel eq 0) and shift(linedel,1), nlines ), size ]
word = [ 0,data(w(0):w(1)-1) ]
nwords = total( word ne shift(word,1) )/2

if (keyword_set(int)) then begin
	res = intarr( nwords,nlines )
endif else begin
	res = fltarr( nwords,nlines )
endelse

w = where( a eq 124B, nbars )
wlf = where( a eq 13B, nlf )
if nbars gt 0 or n_params() eq 2 or nlf gt 0 or keyword_set(carr) then begin
	if nbars gt 0 then a(w) = 32B
        if nlf gt 0 then a(wlf) = 10B
	fname = 'temporary_text_file'
	openw,1,fname
	writeu,1,a
	close,1
endif else fname = filename

if not keyword_set( quiet ) then begin
	print,'Reading in:',fix(nlines),' lines'
	;print,'           ',fix(nwords),' words on each line.'
end

openr,1,fname
readf,1,res
close,1

if nbars gt 0 or n_params() eq 2 or nlf gt 0 then begin
	openr,2,'temporary_text_file',/DELETE
	close,2
end


;Determine the size of the wavefront
res = reverse(res,2)
size_wavefront_x = (size(res))[1]
size_wavefront_y = (size(res))[2]
first_x = 0
last_x = size_wavefront_x-1
size_x = size_wavefront_x
first_y = 0
last_y = size_wavefront_y-1
size_y = size_wavefront_y

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

res = res[first_x:last_x,first_y:last_y]

return,res
end

