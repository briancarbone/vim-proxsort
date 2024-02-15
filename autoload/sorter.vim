vim9script

export def ProxSort(ctx: string, paths: list<string>): list<string>
  if empty(ctx)
    return paths
  endif

  const ctxparts = Parts(ctx)
  const ctxlen = len(ctxparts)

  var entries = mapnew(paths, (pathidx, path) => {
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

    return {prox: prox, path: path, i: pathidx}
  })

  return entries
    ->sort(EntryComparator)
    ->map((_, d) => d.path)
enddef

def Parts(path: string): list<string>
  var std = simplify(path)
    ->substitute('\\', '/', 'g')
    ->split('/')
  return std[0] == '.' ? std[1 : ] : std
enddef

def EntryComparator(d1: dict<any>, d2: dict<any>): number
  var proxdiff = d2.prox - d1.prox
  return proxdiff == 0 ? d1.i - d2.i : proxdiff
enddef
