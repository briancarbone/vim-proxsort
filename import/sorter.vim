vim9script

export def ProxSort(ctx: string, paths: list<string>): list<string>
  if empty(ctx)
    return paths
  endif

  const ctxparts = Parts(ctx)
  const ctxlen = len(ctxparts)

  var entries: list<Line> = mapnew(paths, (pathidx, path) => {
    var parts = Parts(path)
    var partslen = len(parts)
    var prox = 0

    for partidx in range(partslen)
      if partidx < ctxlen && parts[partidx] == ctxparts[partidx]
        prox += 1
      else
        prox -= partslen - partidx
        break
      endif
    endfor

    return Line.new(prox, path, pathidx)
  })

  return entries
    ->sort(Line.Eq)
    ->mapnew((_, ln: Line) => ln.path)
enddef

def Parts(path: string): list<string>
  var std = simplify(path)
    ->substitute('\\', '/', 'g')
    ->split('/')
  return std[0] == '.' ? std[1 : ] : std
enddef

class Line
  final prox: number
  final path: string
  final i: number

  def new(this.prox, this.path, this.i)
  enddef

  static def Eq(ln1: Line, ln2: Line): number
    var proxdiff = ln2.prox - ln1.prox
    return proxdiff == 0 ? ln1.i - ln2.i : proxdiff
  enddef
endclass
