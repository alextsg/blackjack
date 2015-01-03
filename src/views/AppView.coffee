# Contains a deck, playerHand, and dealerHand

class window.AppView extends Backbone.View
  template: _.template '
    <button class="hit-button">Hit</button>
    <button class="stand-button">Stand</button>
    <button class="newgame-button">New Game</button>
    <div class="player-hand-container"></div>
    <div class="dealer-hand-container"></div>
  '

  events:
    'click .hit-button': -> @model.get('playerHand').hit()
    'click .stand-button': -> @model.get('dealerHand').stand(@model.get('playerHand'))
    'click .newgame-button': -> window.location.reload true

  initialize: ->
    @model.get('playerHand').on 'bust', =>
      @$('.hit-button').attr 'disabled', true
      @$('.stand-button').attr 'disabled', true

    @model.get('dealerHand').on 'done', =>
      @$('.hit-button').attr 'disabled', true
      @$('.stand-button').attr 'disabled', true

    @render()

  render: ->
    @$el.children().detach()
    @$el.html @template()
    @$('.player-hand-container').html new HandView(collection: @model.get 'playerHand').el
    @$('.dealer-hand-container').html new HandView(collection: @model.get 'dealerHand').el

