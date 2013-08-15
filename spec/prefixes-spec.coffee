helpers = require './spec-helper'

describe "Prefixes", ->
  [editor, vimState] = []

  beforeEach ->
    vimMode = atom.loadPackage('vim-mode')
    vimMode.activateResources()

    editor = helpers.cacheEditor(editor)

    vimState = editor.vimState
    vimState.activateCommandMode()
    vimState.resetCommandMode()

  keydown = (key, options={}) ->
    options.element ?= editor[0]
    helpers.keydown(key, options)

  describe "Repeat", ->
    describe "with operations", ->
      beforeEach ->
        editor.setText("123456789abc")
        editor.setCursorScreenPosition([0, 0])

      it "repeats N times", ->
        keydown('3')
        keydown('x')

        expect(editor.getText()).toBe '456789abc'

      it "repeats NN times", ->
        keydown('1')
        keydown('0')
        keydown('x')

        expect(editor.getText()).toBe 'bc'

    describe "with motions", ->
      beforeEach ->
        editor.setText('one two three')
        editor.setCursorScreenPosition([0, 0])

      it "repeats N times", ->
        keydown('d')
        keydown('2')
        keydown('w')

        expect(editor.getText()).toBe 'three'
