<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
  
    <link  id="cssArchivo" rel="stylesheet" type="text/css" href ="<c:url value="/resources/stylesheets/Formato2.css" />"  />

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
            <li><a href="">Inicio</a></li>
            <li><a href="/help">Ayuda</a></li>
            <li><a href="/about">Sobre Mi</a></li>
          </ul>
        </div><!--/.nav-collapse -->
      </div>
    </nav>
    <div class="container-fluid" id="panelIde">
		<div class= "col-md-12">
    	    <div id="botoneraEjecucion" class="btn-group col-xs-12 col-md-7">
                <button type="button" class="btn btn-default col-md-6" id="volver">Volver</button>
                <select id="ventanas" class="col-md-6 selectpicker" 
                    title="Ventanas Habilitadas" data-selected-text-format="count"
                    multiple="multiple">
                    <option value="0">Codigo Fuente</option>
                    <option value="1">Codigo Compilado</option>
                    <option value="2">Simulacion</option>
                </select>
            </div>
    	    <div id="botoneraEjecucion1" class="btn-group col-md-5">
              <button type="button" class="btn btn-default col-md-6" id="siguientePaso">Siguiente Paso</button>
		      <button type="button" class="btn btn-default col-md-6" id="detener">Detener Ejecución</button>
            </div>
        </div>
 	    <panelcode-app :panel="panelCode" :index="0" v-if="panelCode.ver"></panelcode-app>
        <panelcompilado-app :panel="panelCompilado" :index="1" v-if="panelCompilado.ver"></panelcompilado-app>
        <panelsimulacion-app :panel="panelSimulacion" :index="2" v-if="panelSimulacion.ver"></panelsimulacion-app>
	</div>
        
    <footer class="link-footer" id="link-footer">
        <div class="width-wrapper" id="link-footer-width-wrapper">
            <div class=".col-md-8" id="linksFooter">
                <nav class="link-footer-links link-footer-codepen-links" id="link-footer-codepen-links">
                    <strong>OCuns</strong>
                    <a href="/about/">About</a>
                    <a href="/support/">Support</a>
                    <a href="/">Section</a>
                </nav>
                <nav class="link-footer-links link-footer-community-links" id="link-footer-community-links">
                  <strong>Community</strong>
                  <a href="/jobs/">Jobs</a>
                  <a href="https://blog.codepen.io/meetups/">Meetups</a>
                  <a href="/pro/teams/">Teams</a>
                  <a href="/patterns/">Patterns</a>
                  <a href="https://blog.codepen.io/legal/code-conduct/">Code of Conduct</a>
                </nav>
                <nav class="link-footer-links link-footer-social-links" id="link-footer-social-links">
                    <strong>Social</strong>}
                    <a href="https://twitter.com/">Twitter</a>
                    <a href="https://www.facebook.com/CEComUNS/">Facebook</a>
                    <a href="https://www.instagram.com/CEComUNS/">Instagram</a>
                </nav>
            </div>
            <div class="copyright .col-md-4" id="link-footer-copyright">
                <h1 class="logo header-chunk">
                    <a href="https://www.facebook.com/CEComUNS/" class="small-screen-logo">
                        <img src="images/logo.png" border="1" alt="Logo del Centro" class="col-md-3" id="logo" >
                    </a>
                </h1>        
            </div>
        </div>
    </footer>

    

    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" integrity="sha384-Tc5IQib027qvyjSMfHjOMaLkfuWVxZxUPnCJA7l2mCWNIpG9mGCD8wGNIcPD7Txa" crossorigin="anonymous"></script>


    <!-- Templates-->
    <!--Heading-->
    <script type="text/x-template" id="headingTemplate">
        <div class="panel-heading">
            <h3 class="panel-title col-md-11">{{getTitulo}}</h3>
            <button type="button" class="btn btn-default col-md-1 closebutton" 
            data-toggle="collapse" :data-target="getTarget" >-</button>
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
                   <h3 class="panel-title">Codigo Compilado</h3>
                </div>
                <div class="panel-body">
                   <form role="form">
                        <textarea id="codigoCompilado"
                          rows="20"
                          ng-model="code"
                          v-model="panel.value"
                          readonly>     
                        </textarea>
                        <div id="barraCompilar">
                            <select class="selectpicker col-md-8" id="tipoEjecucion">
                                <option>Todo el Código</option>
                                <option>De a 1 Instrucción</option>
                            </select>   
                            <button type="button" class="btn btn-default col-md-4" id="ejecutar">Ejecutar</button>
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
                   <h3 class="panel-title">Codigo Fuente</h3>
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
                          <textarea id="dirInicio" class="col-md-2" rows="1" cols="2" 
                          maxlength="2" v-model="panel.direccionInicio">
                          </textarea>
                          <button type="button" class="btn btn-default col-md-4" 
                          id="compilar" @click="Compilar">
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
            <panelheading targets="#bodyRegistro" titulo="Registros del Procesador"></panelheading>
            <div class="panel-body collapse in" id="bodyRegistro">
                <registro-table-app :registros="registros" :inicio="0" :fin="8" id="row1"> 
                </registro-table-app>
                <registro-table-app :registros="registros" :inicio="8" :fin="16" id="row1"> 
                </registro-table-app>
            </div>
        </div>
    </script>

    |<!--Panel de Registros-->
    <script type="text/x-template" id="logsTemplate">
        <div class="panel panel-default" id="panelLogs">
            <panelheading targets="#bodyLog" titulo="Logs del Sistema"></panelheading>
            <div class="panel-body collapse" id="bodyLog">
                <table class="table table-bordered" id="tablaMemoria">
                    <tbody>
                        <textarea id="Logs"
                          class="form-control source-code"
                          style="margin-bottom:5px;"
                          rows="5"
                          tab-support
                          select-line
                          ng-model="code"
                          v-model="logs.value"
                          readonly></textarea>
                    </tbody>
                </table>
            </div>
        </div>
    </script>


    |<!--Panel de Memoria -->
    <script type="text/x-template" id="memoriaPanelTemplate">
        <div class="panel panel-default" id="panelMemoria">
            <panelheading targets="#bodyMemoria" titulo="Memoria del Sistema"></panelheading>
            <div class="panel-body collapse" id="bodyMemoria">
                <memoria-table-app :memorias="memorias" :cantxfilas="16" id="tablaMemoria"> 
                </memoria-table-app>
            </div>
        </div>
    </script>


    <!--Funciones-->
    
    <script src="/javascripts/vue.js" type="text/javascript"></script>
    <script src="/javascripts/bootstrap-select.js"></script>
    <script src="/javascripts/funciones.js" type="text/javascript"></script>
    <script src="/javascripts/components.js" type="text/javascript"></script>
    </body>
</html>


