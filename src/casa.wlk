object casaDePepeYJulian {
	var viveres = 50
	var montoReparaciones = 0
	var cuentaAsignada = cuentaCorriente
	var estrategia = minimo
	method tieneSufucientes(){
		return(viveres>40)
	}
	method agregarViveres(viveres_){
		viveres = viveres + viveres_
	}
	method establecerViveres(viveres_){
		viveres = viveres_
	}
	method viveres(){
		return viveres
	}
	method necesitaReparar(){
		return(montoReparaciones > 0)
	}
	method montoReparaciones(){
		return montoReparaciones
	}
	method repararCasa(){
		if(montoReparaciones<=cuentaAsignada.saldo()){
			self.realizarGasto(montoReparaciones)
			montoReparaciones = 0
		}
	}
	method casaEnOrden(){
		return (not self.necesitaReparar()) and self.tieneSufucientes()
	}
	method romperAlgo(costo){
		montoReparaciones = montoReparaciones + costo
	}
	method asignarCuenta(cuenta){
		cuentaAsignada = cuenta
	}
	method cuenta(){
		return cuentaAsignada
	}
	method saldoCuenta(){
		return cuentaAsignada.saldo()
	}
	method realizarGasto(costo){
		cuentaAsignada.extraer(costo)
	}
	method depositarDinero(cantidad){
		cuentaAsignada.depositar(cantidad)
	}
	method elegirEstrategia(estrategia_,calidad){
		estrategia = estrategia_
	}
	method usarEstrategia(){
		estrategia.ejecutar(self)
	}
}

//cuentas
object cuentaCorriente{
	var saldo = 500
	method saldo(){
		return(saldo)
	}
	method depositar(cantidad){
		saldo = saldo + cantidad
	}
	method extraer(cantidad){
		saldo = saldo - cantidad
		}
}
object cuentaGastos{
	var saldo = 0
	const costeOperacion = 50
	method saldo(){
		return(saldo)
	}
	method depositar(cantidad){
		saldo = saldo + cantidad - costeOperacion
	}
	method extraer(cantidad){
		saldo = saldo - cantidad
		}
}
object cuentaCombinada{
	var cuentaPrimaria = cuentaGastos
	var cuentaSecundaria = cuentaCorriente
	method saldo(){
		return(cuentaPrimaria.saldo() + cuentaSecundaria.saldo())	
	}
	method depositar(cantidad){
		cuentaPrimaria.depositar(cantidad)
	}
	method extraer(cantidad){
		if(cuentaPrimaria.saldo()>=cantidad){
			cuentaPrimaria.extraer(cantidad)
		}
		else{
			cuentaSecundaria.extraer(cantidad)
		}
	}
	method asignarPrimaria(cuenta){
		cuentaPrimaria = cuenta
	}
	method asignarSecundaria(cuenta){
		cuentaSecundaria = cuenta
	}
}
//estrategias
object minimo{
	var calidad = 5
	const viveresMin = 40
	method ejecutar(casa){
		casa.realizarGasto(self.gastosViveres(casa))
		casa.agregarViveres(self.viveresNecesarios(casa))
	}
	method gastosViveres(casa){
		return if (self.faltanViveres(casa)){
			calidad*(self.viveresNecesarios(casa))
		}else{
			0
		}
	}
	method faltanViveres(casa){
		return casa.viveres()<viveresMin
	}
	method viveresNecesarios(casa){
		return if(self.faltanViveres(casa)){
			viveresMin - casa.viveres()
		}else {
			0
		}
	}
	method elegirCalidad(numero){
		calidad = numero
	}
}
object full{
	const calidad = 5
	var viveresMin = 40
	method ejecutar(casa){
		if(casa.casaEnOrden()){
			viveresMin = 100
			self.comprarViveres(casa)
		}else{
			viveresMin = 40 + casa.viveres()
			self.comprarViveres(casa)
			self.pagarReparaciones(casa)
		}
	}
	method comprarViveres(casa){
		casa.realizarGasto(self.gastosViveres(casa))
		casa.agregarViveres(self.viveresNecesarios(casa))
	}
	method gastosViveres(casa){
		return if (self.faltanViveres(casa)){
			calidad*(self.viveresNecesarios(casa))
		}else{
			0
		}
	}
	method faltanViveres(casa){
		return casa.viveres()<viveresMin
	}
	method viveresNecesarios(casa){
		return if(self.faltanViveres(casa)){
			viveresMin - casa.viveres()
		}else {
			0
		}
	}
	method pagarReparaciones(casa){
		if (casa.saldoCuenta()>1000){
			casa.repararCasa()
		}else{}
	}
}