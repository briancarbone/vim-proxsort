vim9script

import 'sorter.vim'

def ListCmd(): list<string>
  var base = fnamemodify(expand('%'), ':h:.:S')
  var paths = systemlist('fd -t f -L')
  return base != '.' ? sorter.ProxSort(shellescape(expand('%')), paths) : paths
enddef

command! -bang -nargs=? -complete=dir Files {
  fzf#vim#files(<q-args>, {source: ListCmd(), options: '--tiebreak=index'}, <bang>0)
}
