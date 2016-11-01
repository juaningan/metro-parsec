require 'tk'

# Definimos nueva fuente y reemplazamos las originales por ella
ctcFont = TkFont.new('-bitstream-swiss 742-medium-r-normal--19-140-85-85-p-110-hp-roman8')
TkOptionDB.add("*Font", ctcFont)

base = TkRoot.new {
  overrideredirect 1 #Ventana raiz sin decoracion
  geometry '167x50+1107+967'
}

TkGrid.rowconfigure(base, 0, 'weight'=>1)
TkGrid.columnconfigure(base, 0, 'weight'=>1)

frame = TkFrame.new(base).grid(:row=>0, :column=>0, :sticky=>'news')
frame['bg']='black'

def splashscreen(app, cmd)
  begin
  splash = TkToplevel.new {
    overrideredirect 1 #Ventana raiz sin decoracion
    geometry '300x100+490+462'
  }
  label = TkLabel.new(splash) {
    text 'Gestionando ' + app + '...'
    pack('pady'=>20)
  }
  splash.update
  ensure
  system(cmd)
  system('xdotool search --name --sync "Gestion de los trabajos nocturnos"')
    splash.destroy
  end
end

  
#Los botones los definimos en un hash para poder cambiar el estado en el metodo change_state
botones = {
  'enr' => TkButton.new(frame){
    grid(:column=>0, :row=>0, :sticky=>'news', :padx=>2, :pady=>2)
    text 'Enrutador'
    borderwidth 1
    command "system '/opt/metro/botonesctc/enr_wrapper.sh'"
  },
  'sir' => TkButton.new(frame){
    grid(:column=>1, :row=>0, :sticky=>'news', :padx=>2, :pady=>2)
    text 'Sirei'
    borderwidth 1
    command "system '/opt/metro/botonesctc/sir_wrapper.sh'"
  },
  'ats' => TkButton.new(frame){
    grid(:column=>0, :row=>1, :sticky=>'news', :padx=>2, :pady=>2)
    text 'ATS'
    borderwidth 1
    command "system '/opt/metro/botonesctc/ats_wrapper.sh'"
  },
  'tra' => TkButton.new(frame){
    grid(:column=>1, :row=>1, :sticky=>'news', :padx=>2, :pady=>2)
    text 'Trabajos'
    borderwidth 1
    command "system '/opt/metro/botonesctc/tra_wrapper.sh'"
  },
}

TkGrid.rowconfigure(frame, 0, 'weight'=>1)
TkGrid.columnconfigure(frame, 0, 'weight'=>1)
TkGrid.rowconfigure(frame, 1, 'weight'=>1)
TkGrid.columnconfigure(frame, 1, 'weight'=>1)

def change_state(root, btn)
  root.raise
  display = ENV['DISPLAY']
  # Busca el display y trunca lo que encuentra para que coincida con el nombre de los botones.
  appdisp = File.readlines("/var/tmp/APP").select{|x| x.include?(display)}.map{|x|x[0..2]} 
  if appdisp.size > 0 # Este if es para ahorrarnos buscar los null si ya encuentra pantalla
    btn.keys.each do |ad|
      # Activa la app en este display y desactiva el resto
      if appdisp.include?(ad)
        btn[ad].state = :normal
      else
        btn[ad].state = :disabled
      end
    end
  else
    appnull = File.readlines("/var/tmp/APP").select{|x| x.include?("null")}.map{|x|x[0..2]}
    btn.keys.each do |an|
      # Activa las apps sin abrir y desactiva el resto (en otras pantallas)
      if appnull.include?(an)
        btn[an].state = :normal
      else
        btn[an].state = :disabled
      end
    end
  end
end

Thread.new(){
  timer=TkAfter.new(1000,-1,proc {change_state(base, botones)})
  timer.start
}

Tk.mainloop
