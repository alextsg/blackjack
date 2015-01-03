class window.Hand extends Backbone.Collection
  model: Card

  initialize: (array, @deck, @isDealer) ->

  hit: ->
    if @length < 5 then @add(@deck.pop()) else alert 'You can\'t hit that'
    @check()
    return @models[@length-1]

  stand: ->
    @models[0].flip()
    until @scores()[1] > 16 or @scores()[0] > 16 then @hit()
    @trigger('done')

  hasAce: -> @reduce (memo, card) ->
    memo or card.get('value') is 1
  , 0

  minScore: -> @reduce (score, card) ->
    score + if card.get 'revealed' then card.get 'value' else 0
  , 0

  check: ->
    if @scores()[0] > 21 and @scores()[1] > 21 then @trigger('bust')

  scores: ->
    # The scores are an array of potential scores.
    # Usually, that array contains one element. That is the only score.
    # when there is an ace, it offers you two scores - the original score, and score + 10.
    [@minScore(), @minScore() + 10 * @hasAce()]

