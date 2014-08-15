###
If you have multiple cores, the percentage number might exceed 100%
That's because the percentage is represented over just 1 core
so if you have 8 cores it can get up to 800%
###


command: "ps aux  | awk 'BEGIN { sum = 0 }  { sum += $3 }; END { print sum }' && sysctl hw.ncpu | awk '{print $2}'"

refreshFrequency: 2000

style: """
  top: 15px
  left: 15px
  color: #fff
  font-family: Helvetica Neue
  width: 368px
  background: rgba(#000, .5)
  padding: 5px
  border-radius: 5px

  table
    border-collapse: collapse
    table-layout: fixed
    width:100%

  tr
    width: 100%

  td
    font-size: 24px
    font-weight: 100
    width: 100%
    height: 48px
    overflow: hidden
    text-shadow: 0 0 1px rgba(#000, 0.5)

  .widget-title
    font-size 10px
    text-transform uppercase
    font-weight 400

  .wrapper
    padding: 4px 6px 4px 6px
    position: relative
    background: rgba(#CE1C00, 0.6)
    height:90%

  .label
    position: absolute
    top: 28px
    left: 10px
    font-size: 24px
    font-weight: 100

"""

render: -> """
  <table>
   <div class="widget-title">CPU - Meter</div>
   <tr>
      <td id="bar">
      </td>
    </tr>
  </table>
"""

update: (output, domEl) ->
  table = $(domEl).find('table')
  args = output.split('\n')

  render = (cpu,nCores) ->
    '<div class="wrapper" style="width:'+parseInt(cpu/nCores)+'%;"></div><div class="label">'+cpu+'%</div>'

  table.find("#bar").html render(args...)
