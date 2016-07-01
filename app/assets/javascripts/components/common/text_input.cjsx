React = require 'react'
InputMixin = require '../../mixins/input_mixin.cjsx'
Conditional = require('../high_order/conditional.jsx').default

TextInput = React.createClass(
  displayName: 'TextInput'
  mixins: [InputMixin],
  getInitialState: ->
    value: @props.value
  dateChange: (date) ->
    value = if date? then date.format('YYYY-MM-DD') else ''
    @onChange({ target: { value: value } })
  render: ->
    spacer = @props.spacer || ': '
    if @props.label
      label = @props.label
      label += spacer
    value = @props.value

    valueClass = 'text-input-component__value '
    valueClass += @props.valueClass if @props.valueClass

    if @props.editable
      labelClass = ''
      inputClass = if @props.inline? && @props.inline then ' inline' else ''
      if @state.invalid
        labelClass += 'red'
        inputClass += 'invalid'

      if @props.type == 'number'
        title = I18n.t('accessibility.number_field')

      input = (
        <input
          ref='input'
          className={"#{inputClass} #{@props.value_key}"}
          id={@state.id}
          value={@state.value}
          onChange={@onChange}
          autoFocus={@props.focus}
          onFocus={@focus}
          onBlur={@blur}
          type={@props.type || 'text'}
          placeholder={@props.placeholder}
          title={title}
          disabled={@props.enabled? && !@props.enabled}
          min=0
        />
      )

      <div className="form-group">
        <label htmlFor={@state.id} className={labelClass}>{label}</label>
        {input}
      </div>
    else if @props.label
      <p className={@props.p_tag_classname}>
        <span className="text-input-component__label"><strong>{label}</strong></span>
        <span>{spacer if (@props.value? or @props.editable) && !@props.label}</span>
        <span onBlur={@props.onBlur} onClick={@props.onClick} className={valueClass}>{value}</span>
        {@props.append}
      </p>
    else
      <span>{value}</span>
)

module.exports = Conditional(TextInput)
