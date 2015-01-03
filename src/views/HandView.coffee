class window.HandView extends Backbone.View
  className: 'hand'

  template: _.template '
    <h2>
      <% if(isDealer){ %>Dealer<% }else{ %>You<% } %> (<span class="score"></span>)
      <span id="bust"></span>
    </h2>
  '

  initialize: ->
    @collection.on 'add remove change dealerHand', => @render()
    @render()

  render: ->
    @$el.children().detach()
    @$el.html @template @collection
    @$el.append @collection.map (card) ->
      new CardView(model: card).$el

    score = @collection.scores()
    min = Math.min score[0], score[1]
    max = Math.max score[0], score[1]
    if score[0] <= 21 && score[1] <= 21
      @$('.score').text max
    if score[0] <= 21 && score[1] > 21
      @$('.score').text score[0]
    if score[0] > 21
      @$('.score').text min
      @$('#bust').append ' Busted'

