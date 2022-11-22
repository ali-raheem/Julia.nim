import std/complex, std/math, std/random

const width = 1920*2
const height = 1080*2
const maxValue = 255
const numColours = 16

type
  RGB = enum
    red, green, blue
  Colour = array[red..blue, int]
  Palette = array[0..numColours, Colour]


const paletteSize = maxValue/numColours

const scaleX = 1.92
const scaleY = 1.08
const escape = 5*pow((scaleX * scaleY), 2)
const maxIter = maxValue
const zc = complex(-0.4, 0.6)

var
  p: Palette

randomize()
for c in p.mitems:
  c[red] = rand(0..maxValue)
  c[green] = rand(0..maxValue)
  c[blue] = rand(0..maxValue)

echo "P3"
echo width, " ", height
echo maxValue
for row in countup(1, height):
  for col in countup(1, width):
    let zx = col/width - 0.5
    let zy = row/height - 0.5
    var z = complex(scaleX * zx, scaleY * zy)
    var i = 0
    while abs(z) < escape and i < maxIter:
      z = pow(z, 2) + zc
      inc i
    let cIdx = int(i / maxIter * maxValue)
    let c = p[int(cIdx/16)]
    echo c[red]
    echo c[green]
    echo c[blue]
