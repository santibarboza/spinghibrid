<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
  <head>
    <title>OCUNS-Entorno Web</title>

    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    
    <link rel="stylesheet" 
        href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css"
        integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u" 
        crossorigin="anonymous">

    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-select/1.12.4/css/bootstrap-select.min.css">
    <link  id="cssArchivo" rel="stylesheet" type="text/css" href = "resources/stylesheets/Formato2.css" />

  </head>
  <body>
    
    <nav class="navbar navbar-inverse navbar-fixed-top">
      <div class="container">
        <div class="navbar-header">
          <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#navbar" aria-expanded="false" aria-controls="navbar">
            <span class="sr-only">Toggle navigation</span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
          </button>
          <a class="navbar-brand" href="">OCUNS Entorno Web</a>
        </div>
        <div id="navbar" class="collapse navbar-collapse">
          <ul class="nav navbar-nav">
            <li><a href="/">Inicio</a></li>
            <li><a href="/help">Ayuda</a></li>
            <li><a href="/about">Sobre Mi</a></li>
          </ul>
        </div><!--/.nav-collapse -->
      </div>
    </nav>
    <form>
        <input type="file" id="archivoAbierto" style="display:none" >
    </form>
    <div class="container-fluid" id="panelIde">
		<div class= "col-md-12">
            <modal-mensaje-app :modal="modal"></modal-mensaje-app>
    	    <botonera-ejecucion-app :botonera="botoneraEjecucion"></botonera-ejecucion-app>
            <botonera-ventanas-app></botonera-ventanas-app>
        </div>
        <div class= "col-md-12">
     	    <panelcode-app :panel="panelCode" :index="0" v-if="panelCode.ver"></panelcode-app>
            <panelcompilado-app :panel="panelCompilado" :index="1" v-if="panelCompilado.ver"></panelcompilado-app>
            <panelsimulacion-app :panel="panelSimulacion" :index="2" v-if="panelSimulacion.ver"></panelsimulacion-app>
        </div>
	</div> 

    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" integrity="sha384-Tc5IQib027qvyjSMfHjOMaLkfuWVxZxUPnCJA7l2mCWNIpG9mGCD8wGNIcPD7Txa" crossorigin="anonymous"></script>


    <!-- Templates-->
    <!--Heading-->
    <script type="text/x-template" id="headingTemplate">
        <div class="panel-heading">
            <h3 class="panel-title col-md-11">{{getTitulo}}</h3>
            <botonDesplegar :targets="targets" :desplegado="desplegado"></botonDesplegar>
        </div>
    </script>
    <!--Registro-->
    <script type="text/x-template" id="registroTemplate">
        <th
            class="h5 tablaRegistro" :class="{Ultimo: ultimoCambio}" :title="getTitulo">
                {{registro.contenido}}       
        </th>        
    </script>

    <!--Tabla Registros-->
    <script type="text/x-template" id="registroTableTemplate">
        <table class="table table-bordered">
            <thead><tr>
                <th v-for="(registro,i) in registros" v-if="enRango(i)" 
                style="padding-top:3px;padding-bottom:3px;text-align:center;">
                    {{getTitulo(i)}}
                </th>
            </tr></thead>
            <tbody> <tr>
               <th is="registro-app" v-for="(registro,i) in registros" 
                :registro="registro" :index="i" v-if="enRango(i)">
                </th>
            </tr></tbody>
        </table>
    </script>       
   
    <!--Memoria-->
    <script type="text/x-template" id="memoriaTemplate">
        <th 
            class="h5 tablaMemoria"  :title="getTitulo" :class="clasesMemoria"
            style="padding:0px;text-align:center;">
                {{memoria.contenido}}
        </th>      
    </script>

    <!--Tabla Memoria-->
    <script type="text/x-template" id="memoriaTableTemplate">
        <table class="table table-bordered">
            <tbody>
                <tr v-for="i in cantxfilas">
                    <th is="memoria-app" v-for="j in cantfilas" 
                        style="padding:0px;text-align:center;"
                        :memoria="getMemoria(i,j)" :index="getIndex(i,j)" >
                    </th>
                </tr >
            </tbody>
        </table>
    </script>       
    
    <!--CodigoCompilado-->
    <script type="text/x-template" id="compiladoTemplate">
        <div id="contenedorCompilado" class="col-xs-12" :class="getBigSize">
            <div class="panel panel-default" id="panelCompilado">
               <div class="panel-heading">
                    <h3 class="panel-title col-md-10">Compilado</h3> 
                    <button title="Descargar Codigo Compilado" class="btn btn-default col-md-2 menuB"
                    @click="descargarCompilado">
                        <span class="glyphicon glyphicon-save" aria-hidden="true"></span>
                    </button>
                </div>
                <div class="panel-body">
                   <form role="form">
                        <textarea id="codigoCompilado"
                          rows="20"
                          v-model="panel.value"
                          readonly>     
                        </textarea>
                        <div id="barraCompilar">
                            <select class="selectpicker col-md-8" id="tipoEjecucion">
                                <option>De a 1 Instrucción</option>
                                <option>Todo el Código</option>
                            </select>   
                            <button type="button" class="btn btn-default col-md-4" title="Ejecutar" 
                                :disabled="!panel.habilitaEjecucion" 
                                @click="ejecutar" id="ejecutar">
                                Ejecutar
                            </button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </script>   


        
    <!--CodigoFuente-->
    <script type="text/x-template" id="codeTemplate">
        <div id="contenedorCode" class="col-xs-12" :class="getBigSize">
            <div class="panel panel-default" id="panelCode">
                <div class="panel-heading">
                    <h3 style="" class="panel-title col-md-8">Codigo Fuente</h3> 
                    <a href="javascript:doClick()" title="Abrir Archivo" class="btn btn-default col-md-2 menuB">
                        <span class="glyphicon glyphicon-folder-open" aria-hidden="true"></span>
                    </a>
                    <button class="btn btn-default col-md-2 menuB" title="Descargar Codigo Fuente">
                        <span class="glyphicon glyphicon-save" aria-hidden="true"></span>
                    </button>               
                </div>
                <div class="panel-body">
                    <form role="form">
                        <textarea id="sourceCode"
                          class="form-control source-code"
                          style="margin-bottom:5px;"
                          rows="20"
                          tab-support
                          select-line
                          v-model="panel.value">
                        </textarea>
                        <div id="barraCompilar">
                          <h5 class="col-md-6" id="labeldirinicio">Direccion de Inicio:</h5>
                          <textarea id="dirInicio" class="col-md-2" rows="1" cols="2" title="Dirección de Inicio" 
                          maxlength="2" v-model="panel.direccionInicio">
                          </textarea>
                          <button type="button" class="btn btn-default col-md-4" 
                          id="compilar" title="Compilar Codigo Fuente" @click="Compilar">
                            Compilar
                          </button>
                        </div> 
                    </form>
              </div>
           </div>
        </div>
    </script>

    <!--Panel Simulacion-->
    <script type="text/x-template" id="simulacionTemplate">
        <div id="contenedorSimulacion"  class="col-xs-12" :class="getBigSize">
                <div id="panelSimulacion">
                    <registro-panel-app :registros="panel.registros"></registro-panel-app>
                    <panelmemoria-app :memorias="panel.memorias"></panelmemoria-app>
                    <panellogs-app :logs="panel.logs"></panellogs-app>
                </div>
            </div>
    </script>

    <!--Panel de Registros-->
    <script type="text/x-template" id="registroPanelTemplate">
        <div class="panel panel-default" id="panelRegistros">
            <panelheading targets="#bodyRegistro" titulo="Registros del Procesador"
            :desplegado="registros.desplegado"></panelheading>
            <div class="panel-body collapse in" id="bodyRegistro">
                <registro-table-app :registros="registros.value" :inicio="0" :fin="8" id="row1"> 
                </registro-table-app>
                <registro-table-app :registros="registros.value" :inicio="8" :fin="16" id="row1"> 
                </registro-table-app>
            </div>
        </div>
    </script>

    <!--Panel de Logs-->
    <script type="text/x-template" id="logsTemplate">
         <div class="panel panel-default" id="panelLogs">
                <div class="panel-heading">
                <h3 class="panel-title col-md-9">Logs del Sistema</h3>
                <button class="btn btn-default col-md-1 menuB" title="Borrar Logs"  
                    @click="borrarLogs">
                        <span class="glyphicon glyphicon-trash" aria-hidden="true"></span>
                </button>
                <button title="Descargar Logs" class="btn btn-default col-md-1 menuB"
                    @click="descargarLogs">
                        <span class="glyphicon glyphicon-save" aria-hidden="true"></span>
                </button>
                <botonDesplegar targets="#bodyLog" :desplegado="logs.desplegado">
                </botonDesplegar>
            </div>
            <div class="panel-body collapse" id="bodyLog">
                <table class="table table-bordered" id="tablaMemoria">
                    <tbody>
                        <textarea id="Logs"
                          class="form-control source-code"
                          style="margin-bottom:5px;"
                          rows="5"
                          tab-support
                          select-line
                          v-model="logs.value"
                          readonly></textarea>
                    </tbody>
                </table>
            </div>
        </div>
    </script>

    <!--Boton Desplegar -->
    <script type="text/x-template" id="botonDesplegarTemplate">
        <button type="button" :title="getTitle" class="btn btn-default col-md-1 closebutton" 
        data-toggle="collapse" :data-target="getTarget" @click="toogle">
            <span class="glyphicon" :class="getIcono" aria-hidden="true"></span>
        </button>
    </script>

    <!--Panel de Memoria -->
    <script type="text/x-template" id="memoriaPanelTemplate">
        <div class="panel panel-default" id="panelMemoria">
            <panelheading targets="#bodyMemoria" titulo="Memoria del Sistema"
            :desplegado="memorias.desplegado"></panelheading>
            <div class="panel-body collapse" id="bodyMemoria">
                <memoria-table-app :memorias="memorias.value" :cantxfilas="16" id="tablaMemoria"> 
                </memoria-table-app>
            </div>
        </div>
    </script>

<!--Modal de Mensaje-->
    <script type="text/x-template" id="modalTemplate">
        <div class="modal fade" id="mostrarmodal" tabindex="-1" role="dialog" 
            aria-labelledby="basicModal" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-body">
                        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                        <h3>{{modal.mensaje}}</h3>    
                    </div>
                    <div class="modal-footer">
                        <a class="col-md-2"> </a>
                        <a data-dismiss="modal" class="btn btn-primary col-md-8">Aceptar
                        </a>
                    </div>
                </div>
            </div>
        </div>
    </script>
    
    <!--Botonera Ejecucion-->
    <script type="text/x-template" id="botoneraEjecuccionTemplate">
        <div id="botoneraEjecucion1" class="btn-group col-md-5">
          <button type="button" class="btn btn-default col-md-6" :disabled="!botonera.habilita_PAP" title="Ejecutar Siguiente Instrucción" 
           @click="obtenerSiguientePaso" id="siguientePaso">
            Siguiente Paso
          </button>
          <button type="button" class="btn btn-default col-md-6" :disabled="!botonera.ejecutando" title="Detener Ejecución" 
          @click="detenerEjecucion" id="detener">
            Detener Ejecución
          </button>
        </div>
    </script>

    <!--Botonera Ventanas-->
    <script type="text/x-template" id="botoneraVentanasTemplate">
        <div id="botoneraEjecucion" class="btn-group col-xs-12 col-md-7">
            <a href="/" class="btn btn-default col-md-6" id="volver" title="Volver">
                Volver
            </a>
            <select id="ventanas" class="col-md-6 selectpicker" 
                title="Ventanas Habilitadas" data-selected-text-format="count"
                multiple="multiple">
                <option value="0">Codigo Fuente</option>
                <option value="1">Codigo Compilado</option>
                <option value="2">Simulacion</option>
            </select>
        </div>
    </script>


    <!--Funciones-->
    
    <script src="resources/javascripts/vue.js" type="text/javascript"></script>
    <script src="resources/javascripts/bootstrap-select.js"></script>
    <script src="resources/javascripts/funciones.js" type="text/javascript"></script>
    <script src="resources/javascripts/components.js" type="text/javascript"></script>
    </body>

</html>


