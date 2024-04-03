
object casaDePepeYJulian {
	var viveres = 50
	var montoReparaciones = 0
	var cuentaAsignada = cuentaCorriente
	method tieneSufucientes(){
		return(viveres>40)
	}
	method necesitaReparar(){
		return(montoReparaciones > 0)
	}
	method romperAlgo(costo){
		montoReparaciones = montoReparaciones + costo
	}
	method asignarCuenta(cuenta){
		cuentaAsignada = cuenta
	}
	method realizarGasto(costo){
		cuentaAsignada.extraer(costo)
	}
	method depositarDinero(cantidad){
		cuentaAsignada.depositar(cantidad)
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
