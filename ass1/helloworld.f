      program hello_world
      implicit none
c
      character*32 text
c
      text = 'Hello World'
      write (*,100) text
100   format (A)
c
      end
