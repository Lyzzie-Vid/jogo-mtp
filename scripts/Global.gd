extends Node
var mapa_desbloqueado: bool = false

#Sistema da Visão Espiritual
signal visao_espiritual_mudou(ativa: bool)

var visao_espiritual_desbloqueada: bool = false

var visao_espiritual_ativa: bool = false:
	set(valor):
		if valor == visao_espiritual_ativa:
			return
		visao_espiritual_ativa = valor
		visao_espiritual_mudou.emit(valor)
