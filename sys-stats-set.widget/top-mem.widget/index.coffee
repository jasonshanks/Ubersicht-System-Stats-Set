command: "ps axo \"rss,pid,ucomm\" | sort -nr | head -n3 | awk '{printf \"%8.0f MB,%s,%s\\n\", $1/1024, $3, $2}'"

refreshFrequency: 5000

style: """
  top: 241px
  left: 15px
  color: #fff
  font-family: Helvetica Neue
  background: rgba(#000, .5)
  padding: 5px
  border-radius: 5px





  table
    border-collapse: collapse
    table-layout: fixed

  td
    font-size: 24px
    font-weight: 100
    width: 120px
    max-width: 120px
    overflow: hidden
    text-shadow: 0 0 1px rgba(#000, 0.5)

  .widget-title
    font-size 10px
    text-transform uppercase
    font-weight bold

  .wrapper
    padding: 4px 6px 4px 6px
    position: relative

  .col1
    border-right: 1px solid #fff

  .col2
    border-right: 1px solid #fff

  p
    padding: 0
    margin: 0
    font-size: 11px
    font-weight: normal
    max-width: 100%
    color: #ddd
    text-overflow: ellipsis
    text-shadow: none

  .pid
    position: absolute
    top: 2px
    right: 2px
    font-size: 10px
    font-weight: normal

"""


render: ->
  """
  <table>
    <div class="widget-title">Memory - Top</div>
    <tr>
      <td class='col1'></td>
      <td class='col2'></td>
      <td class='col3'></td>
    </tr>
  </table>
"""

update: (output, domEl) ->
  processes = output.split('\n')
  table     = $(domEl).find('table')

  renderProcess = (cpu, name, id) ->
    "<div class='wrapper'>" +
      "#{cpu}<p>#{name}</p>" +
      "<div class='pid'>#{id}</div>" +
    "</div>"

  for process, i in processes
    args = process.split(',')
    table.find(".col#{i+1}").html renderProcess(args...)

