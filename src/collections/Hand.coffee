class window.Hand extends Backbone.Collection
  model: Card

  initialize: (array, @deck, @isDealer) ->
    #console.log @
    #console.log array[0].get('value') + array[1].get('value')
    if !@isDealer and @length == 2
     @trigger('playerWins')
     console.log 'blackjack'
    @check()

  hit: ->
    @add(@deck.pop())
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
    console.log @scores()
    if @scores()[0] > 21 and @scores()[1] > 21 then @trigger('bust')
    else if @scores()[0] == 21 and @length == 2 then @trigger('playerWins')


  scores: ->
    # The scores are an array of potential scores.
    # Usually, that array contains one element. That is the only score.
    # when there is an ace, it offers you two scores - the original score, and score + 10.
    [@minScore(), @minScore() + 10 * @hasAce()]

