c CSCI3180 Principles of Programming Languages
c --- Declaration ---
c I declare that the assignment here submitted is original except for source material explicitly acknowledged.
c I also acknowledge that I am aware of University policy and regulations on honesty in academic work,
c and of the disciplinary guidelines and procedures applicable to breaches of such policy and regulations,
c as contained in the http://www.cuhk.edu.hk/policy/academichonesty/
c Assignment 1
c Name: KO Chi Keung
c Student ID: 1155033234
c Email Addr: ckko3@se.cuhk.edu.hk

      program dda
        implicit none

c Declare variable
        integer n, i, j, data(0:100,2), ios
        character out(0:78,0:22)

c Read from Input File
        open(8, file='input.txt')
        read(8, *, iostat=ios) n
        if (ios .NE. 0) then
          print *, 'CANNOT OPEN INPUT FILE'
          stop
        endif
        i = 0
10      if (i .LT. n) then
          read(8, *) data(i,1), data(i,2)
          i = i + 1
          goto 10
        endif
        close(8)

c Initialize the out array
c origin
        out(0,0) = '+'
c positive y-axis
        i = 1
20      if (i .LT. 23) then
          out(0,i) = '|'
          i = i + 1
          goto 20
        endif
c positive x-axis
        i = 1
30      if (i .LT. 79) then
          out(i,0) = '-'
          i = i + 1
          goto 30
        endif
c space
        i = 1
40      if (i .LT. 79) then
          j = 1
50        if (j .LT. 23) then
            out(i,j) = ' '
            j = j + 1
            goto 50
          endif
          i = i + 1
          goto 40
        endif

c Main program
        i = 0
60      if (i .LT. (n-1)) then
          call analyzer(out,data(i,1),data(i,2),data(i+1,1),data(i+1,2))
          i = i + 1
          goto 60
        endif

c Print output
c        print *, 'printing'
        j = 22
90      if (j .GE. 0) then
          write (*, '(79A)') (out(i,j), i=0,78)
          j = j - 1
          goto 90
        endif

        end

c subroutine: analyzer
c get all the points from two data points
      subroutine analyzer(out,a,b,c,d)
        implicit none

        integer xi, yi, xj, yj, k
        integer a, b, c, d
        real m
        character out(0:78,0:22)

c note that a,b,c,d are dummy variables
        k = 1

c calculate m
        m = (1.0 * (d - b)) / (1.0 * (c - a))

c then divide 2 cases
c case 1
        if (abs(m) .LE. 1) then
c          print *, 'case 1'

c get suitable xi,yi,xj,yj
          if (a .GT. c) then
            xi = c
            yi = d
            xj = a
            yj = b
          endif
          if (a .LE. c) then
            xi = a
            yi = b
            xj = c
            yj = d
          endif

c          print *, xi, ' ', yi
c          point(0,1) = xi
c          point(0,2) = yi
          out(xi,yi) = '*'

70        if (k .LT. (xj-xi)) then
c            print *, xi+k, ' ', nint(yi+k*m)
c            point(k,1) = xi+k
c            point(k,2) = nint(yi+k*m)
            out(xi+k,nint(yi+k*m)) = '*'
            k = k + 1
            goto 70
          end if

c          print *, xj, ' ', yj
c          point(k,1) = xj
c          point(k,2) = yj
          out(xj,yj) = '*'

c          print *, (point(i,1), i=0,k)
c          print *, (point(i,2), i=0,k)
        end if

c case 2
        if (abs(m) .GT. 1) then
c          print *, 'case 2'

c get suitable xi,yi,xj,yj
        if (b .GT. d) then
          xi = c
          yi = d
          xj = a
          yj = b
        endif
        if (b .LE. d) then
          xi = a
          yi = b
          xj = c
          yj = d
        endif
c          print *, xi, ' ', yi
c          point(0,1) = xi
c          point(0,2) = yi
          out(xi,yi) = '*'

80        if (k .LT. (yj-yi)) then
c            print *, nint(xi+k/m), ' ', yi+k
c            point(k,1) = nint(xi+k/m)
c            point(k,2) = yi+k
            out(nint(xi+k/m),yi+k) = '*'
            k = k + 1
            goto 80
          end if

c          print *, xj, ' ', yj
c          point(k,1) = xj
c          point(k,2) = yj
          out(xj,yj) = '*'

c          print *, (point(i,1), i=0,k)
c          print *, (point(i,2), i=0,k)
        end if

        return

      end
