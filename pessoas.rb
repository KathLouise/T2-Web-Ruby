# -*- coding: utf-8 -*-
require 'active_record'

# Só execute este programa depois de criar o banco de dados (ruby
# criaSchema.rb)

# Este exemplo só tem dois "parâmetros" (adapter e database). Porém,
# existem outros: (host, username, password), que podem ser usados com
# outros bancos de dados.
ActiveRecord::Base.establish_connection :adapter => "sqlite3",
                                        :database => "Database.sqlite3" 

=begin

1x1 (Pessoa Profissão)
1xn (Pessoa Sapatos)
nxn (Pessoa Casa)
=end

class Profession <  ActiveRecord::Base; 
  belongs_to :person
end

class Shoe < ActiveRecord::Base; 
  belongs_to :person
end

class House  < ActiveRecord::Base; 
   has_and_belongs_to_many :persons, :join_table => "houses_people"
end

class Person < ActiveRecord::Base; 
  has_one  :professions
  has_many :shoes
  has_and_belongs_to_many :houses, :join_table => "houses_people"
end

#======================================================
#http://guides.rubyonrails.org/active_record_basics.html#update

def upperDow (char)
    if char===char.capitalize then
        return false
    else
        return true
    end
end

def inserePessoa(dados)
    pes = Person.new()
    begin
        if dados.include?('last_name')
            i = dados.index('last_name') + 2
            temp = dados[dados.index('last_name')+1]
            while (i < dados.size) do
                if (upperDow(dados[i]))
                    break
                else
                    dados[dados.index('last_name')+1] = temp << " " << dados[i]
                    i += 1
                end
            end
            pes.last_name = dados[dados.index('last_name')+1]
        end
    
        if dados.include?('first_name')
            i = dados.index('first_name') + 2
            temp = dados[dados.index('first_name')+1]
            while (i < dados.size) do
                if (upperDow(dados[i]))
                    break
                else
                    dados[dados.index('first_name')+1] = temp << " " << dados[i]
                    i += 1
                end
            end
            pes.first_name = dados[dados.index('first_name')+1]
        end
    
        if dados.include?('address')
            i = dados.index('address') + 2
            temp = dados[dados.index('address')+1]
            while (i < dados.size) do
                if (upperDow(dados[i]))
                    break
                else
                    dados[dados.index('address')+1] = temp << " " << dados[i]
                    i += 1
                end
            end
            pes.address = dados[dados.index('address')+1]
        end
    
        if dados.include?('city')
            i = dados.index('city') + 2
            temp = dados[dados.index('city')+1]
            while (i < dados.size) do
                if (upperDow(dados[i]))
                    break
                else
                    dados[dados.index('city')+1] = temp << " " << dados[i]
                    i += 1
                end
            end
            pes.city = dados[dados.index('city')+1]
        end

        pes.save()
        puts "Registro inserido com sucesso"
        p pes
    rescue Exception
        puts "Existem campos inválidos"
    end
end

def insereProfissao(dados)
    prof = Profession.new()

    begin
        if dados.include?('name_person')
            i = dados.index('name_person') + 2
            temp = dados[dados.index('name_person')+1]
            while (i < dados.size) do
                if (upperDow(dados[i]))
                    break
                else
                    dados[dados.index('name_person')+1] = temp << " " << dados[i]
                    i += 1
                end
            end
            
            pessoas = Person.where(:first_name => dados[dados.index('name_person')+1])
            if (!pessoas.nil?)
                pessoas.each do |pes|
                    puts "ID: #{pes.id}, Last Name: #{pes.last_name}, First Name: #{pes.first_name}"
                end
            
                puts "Digite o ID da pessoa para quem deseja inserir"
                id = gets.chomp
                pessoa = Person.find(id)
                prof.person = pessoa
            end
        else
            puts "Não há registros com esse nome"
        end
        
        if dados.include?('name_profession')
            i = dados.index('name_profession') + 2
            temp = dados[dados.index('name_profession')+1]
            while (i < dados.size) do
                if (upperDow(dados[i]))
                    break
                else
                    dados[dados.index('name_profession')+1] = temp << " " << dados[i]
                    i += 1
                end
            end
            prof.name_profession = dados[dados.index('name_profession')+1]
        end

        if dados.include?('area_acting')
            i = dados.index('area_acting') + 2
            temp = dados[dados.index('area_acting')+1]
            while (i < dados.size) do
                if (upperDow(dados[i]))
                    break
                else
                    dados[dados.index('area_acting')+1] = temp << " " << dados[i]
                    i += 1
                end
            end
            prof.area_acting = dados[dados.index('area_acting')+1]
        end

        prof.save()
        puts "Registro inserido com sucesso"
        puts "Profissao: #{prof.person}, #{prof.name_profession}, #{prof.area_acting}"
        p prof
        p pessoa
    rescue Exception
        puts "Existem campos inválidos"
    end
end

def insereSapatos(dados)
    s = Shoe.new()

    begin
        if dados.include?('name_person')
            i = dados.index('name_person') + 2
            temp = dados[dados.index('name_person')+1]
            while (i < dados.size) do
                if (upperDow(dados[i]))
                    break
                else
                    dados[dados.index('name_person')+1] = temp << " " << dados[i]
                    i += 1
                end
            end
            
            pessoas = Person.where(:first_name => dados[dados.index('name_person')+1])
            if (!pessoas.nil?)
                pessoas.each do |pes|
                    puts "ID: #{pes.id}, Last Name: #{pes.last_name}, First Name: #{pes.first_name}"
                end
                
                puts "Digite o ID da pessoa para quem deseja inserir"
                id = gets.chomp
                pessoa = Person.find(id)
                s.person = pessoa
            else
                puts "Não há registros com esse nome"
            end
        else
            save = false
        end
        
        if dados.include?('number')
            s.number = dados[dados.index('number')+1]
        else
            save = false
        end

        if dados.include?('color')
            i = dados.index('color') + 2
            temp = dados[dados.index('color')+1]
            while (i < dados.size) do
                if (upperDow(dados[i]))
                    break
                else
                    dados[dados.index('color')+1] = temp << " " << dados[i]
                    i += 1
                end
            end
            s.color = dados[dados.index('color')+1]
        end
        
        s.save()
        puts "Registro inserido com sucesso"
        puts "Sapato: #{s.person}, #{s.number}, #{s.color}"
        p s
        p pessoa
    rescue Exception
        puts "Existem campos inválidos"
    end
end

def insereCasas(dados)
    h = House.new()
    
    begin
        if dados.include?('name_person')
            i = dados.index('name_person') + 2
            temp = dados[dados.index('name_person')+1]
            while (i < dados.size) do
                if (upperDow(dados[i]))
                    break
                else
                    dados[dados.index('name_person')+1] = temp << " " << dados[i]
                    i += 1
                end
            end
            
            pessoas = Person.where(:first_name => dados[dados.index('name_person')+1])
            if (!pessoas.nil?)
                pessoas.each do |pes|
                    puts "ID: #{pes.id}, Last Name: #{pes.last_name}, First Name: #{pes.first_name}"            
                end
            
                puts "Digite o ID da pessoa para quem deseja inserir"
                id = gets.chomp
                pessoa = Person.find(id)
                h.persons << pessoa
            else
                puts "Não há registros com esse nome"
            end
        end
        
        if dados.include?('address')
            i = dados.index('address') + 2
            temp = dados[dados.index('address')+1]
            while (i < dados.size) do
                if (upperDow(dados[i]))
                    break
                else
                    dados[dados.index('address')+1] = temp << " " << dados[i]
                    i += 1
                end
            end
            h.address = dados[dados.index('address')+1]
        end
        
        if dados.include?('city')
            i = dados.index('city') + 2
            temp = dados[dados.index('city')+1]
            while (i < dados.size) do
                if (upperDow(dados[i]))
                    break
                else
                    dados[dados.index('city')+1] = temp << " " << dados[i]
                    i += 1
                end
            end
            h.city = dados[dados.index('city')+1]
        end
        
        if dados.include?('state')
            i = dados.index('state') + 2
            temp = dados[dados.index('state')+1]
            while (i < dados.size) do
                if (upperDow(dados[i]))
                    break
                else
                    dados[dados.index('state')+1] = temp << " " << dados[i]
                    i += 1
                end
            end
            h.state = dados[dados.index('state')+1]
        end
        
        if dados.include?('country')
            i = dados.index('country') + 2
            temp = dados[dados.index('country')+1]
            while (i < dados.size) do
                if (upperDow(dados[i]))
                    break
                else
                    dados[dados.index('country')+1] = temp << " " << dados[i]
                    i += 1
                end
            end
            h.country = dados[dados.index('country')+1]
        end

        h.save()
        puts "Registro inserido com sucesso"
        puts "Casa: #{h.persons}, #{h.address}, #{h.city}, #{h.state}, #{h.country}"
        p pessoa
        p h
    rescue Exception
        puts "Existem campos inválidos"
    end
end

def insereDados(dados)
    case dados[1]
        when "pessoas"
            inserePessoa(dados)
        when "profissoes"
            insereProfissao(dados)
        when "sapatos"
            insereSapatos(dados)
        when "casas"
            insereCasas(dados)
        else
            puts "Tabela inválida"
    end
end

def alteraPessoa(dados)
    id = Array.new()
    begin 
        if dados.include?('last_name')
            i = dados.index('last_name') + 2
            temp = dados[dados.index('last_name')+1]
            while (i < dados.size) do
                if (upperDow(dados[i]))
                    break
                else
                    dados[dados.index('last_name')+1] = temp << " " << dados[i]
                    i += 1
                end
            end
            pessoas = Person.where(:last_name => dados[dados.index('last_name')+1])
            if (!pessoas.nil?)
                pessoas.each do |pes|
                    id << pes.id
                end
            
                pessoa = Person.find(id.min)
                
                puts "Digite o novo last_name"                
                new = gets.chomp
                pessoa.update(last_name: new)
            else
                puts "Last Name invalido"
            end
        end
            
        if dados.include?('first_name')
            i = dados.index('first_name') + 2
            temp = dados[dados.index('first_name')+1]
            while (i < dados.size) do
                if (upperDow(dados[i]))
                    break
                else
                    dados[dados.index('first_name')+1] = temp << " " << dados[i]
                    i += 1
                end
            end
            pessoas = Person.where(:first_name => dados[dados.index('first_name')+1])
            if (pessoas!=nil)
                pessoas.each do |pes|
                    id << pes.id
                end
                
                pessoa = Person.find(id.min)
            
                puts "Digite o novo first_name"
                new = gets.chomp
                pessoa.update(first_name: new)
            else
                puts "First Name invalido"
            end
        end
            
        if dados.include?('address')
             i = dados.index('address') + 2
            temp = dados[dados.index('address')+1]
            while (i < dados.size) do
                if (upperDow(dados[i]))
                    break
                else
                    dados[dados.index('address')+1] = temp << " " << dados[i]
                    i += 1
                end
            end
            pessoas = Person.where(:address => dados[dados.index('address')+1])
            if (pessoas!=nil)    
                pessoas.each do |pes|
                    id << pes.id
                end
                
                pessoa = Person.find(id.min)
                
                puts "Digite o novo address"
                new = gets.chomp
                pessoa.update(address: new)
            else
                puts "Address invalido"
            end
        end

        if dados.include?('city')
            i = dados.index('city') + 2
            temp = dados[dados.index('city')+1]
            while (i < dados.size) do
                if (upperDow(dados[i]))
                    break
                else
                    dados[dados.index('city')+1] = temp << " " << dados[i]
                    i += 1
                end
            end
            pessoas = Person.where(:city => dados[dados.index('city')+1])
            if (pessoas!=nil)    
                pessoas.each do |pes|
                    id << pes.id
                end
                
                pessoa = Person.find(id.min)
                puts "Digite o novo city"
                new = gets.chomp
                pessoa.update(city: new)
            else
                puts "City invalido"
            end
        end
        puts "Registro alterado com sucesso"
        p pessoa
    rescue Exception
        puts "Existem campos inválidos"
    end
end

def alteraProfissao(dados)
    id = Array.new()
    begin
        if dados.include?('name_profession')
            i = dados.index('name_profession') + 2
            temp = dados[dados.index('name_profession')+1]
            while (i < dados.size) do
                if (upperDow(dados[i]))
                    break
                else
                    dados[dados.index('name_profession')+1] = temp << " " << dados[i]
                    i += 1
                end
            end
            
            profissoes = Profession.where(:name_profession => dados[dados.index('name_profession')+1])
            if (profissoes!=nil)  
                profissoes.each do |prof|
                    id << prof.id
                end
            
                profissao = Profession.find(id.min)
                
                puts "Digite o novo name_profession"                
                new = gets.chomp
                profissao.update(name_profession: new)
            else
                puts "Name Profession invalido"
            end
        end
        
        if dados.include?('area_acting')
            i = dados.index('area_acting') + 2
            temp = dados[dados.index('area_acting')+1]
            while (i < dados.size) do
                if (upperDow(dados[i]))
                    break
                else
                    dados[dados.index('area_acting')+1] = temp << " " << dados[i]
                    i += 1
                end
            end
            
            profissoes = Profession.where(:area_acting => dados[dados.index('area_acting')+1])
            if (profissoes!=nil)    
                profissoes.each do |prof|
                    id << prof.id
                end
                
                profissao = Profession.find(id.min)
                
                puts "Digite a nova area_acting"
                new = gets.chomp
                profissao.update(area_acting: new)
                p profissao
            else
                puts "Area Acting invalido"
            end
        end
        puts "Registro alterado com sucesso"
    rescue Exception
        puts "Existem campos inválidos"
    end
end

def alteraSapatos(dados)
    id = Array.new()
    
    begin
        if dados.include?('number')
            sapatos = Shoe.where(:number => dados[dados.index('number')+1])
            if (sapatos!=nil)    
                sapatos.each do |sap|
                    id << sap.id
                end
            
                sapato = Shoe.find(id.min)
                
                puts "Digite o novo numero do sapato"                
                new = gets.chomp
                sapato.update(number: new)
            else
                puts "Number invalido"
            end
        end
        
        if dados.include?('color')
            i = dados.index('color') + 2
            temp = dados[dados.index('color')+1]
            while (i < dados.size) do
                if (upperDow(dados[i]))
                    break
                else
                    dados[dados.index('color')+1] = temp << " " << dados[i]
                    i += 1
                end
            end
            
            sapatos = Shoe.where(:color => dados[dados.index('color')+1])
            if (sapatos!=nil)    
                sapatos.each do |sap|
                    id << sap.id
                end
                
                sapato = Shoe.find(id.min)
                
                puts "Digite a nova cor do sapato"
                new = gets.chomp
                sapato.update(color: new)
            else
                puts "Color invalido"
            end
        end

        puts "Registro alterado com sucesso"
        p sapato
    rescue Exception
        puts "Existem campos inválidos"
    end
end

def alteraCasas(dados)
    id = Array.new()
    
    begin
        if dados.include?('address')
           i = dados.index('address') + 2
            temp = dados[dados.index('address')+1]
            while (i < dados.size) do
                if (upperDow(dados[i]))
                    break
                else
                    dados[dados.index('address')+1] = temp << " " << dados[i]
                    i += 1
                end
            end
            
            casas = House.where(:address => dados[dados.index('address')+1])
            if (casas!=nil)    
                casas.each do |cas|
                    id << cas.id
                end
                
                casa = House.find(id.min)
                
                puts "Digite o novo address"
                new = gets.chomp
                casa.update(address: new)
            else
                puts "Address invalido"
            end
        end
        
        if dados.include?('city')
            i = dados.index('city') + 2
            temp = dados[dados.index('city')+1]
            while (i < dados.size) do
                if (upperDow(dados[i]))
                    break
                else
                    dados[dados.index('city')+1] = temp << " " << dados[i]
                    i += 1
                end
            end
            casas = House.where(:city => dados[dados.index('city')+1])
            if (casas!=nil) 
                casas.each do |cas|
                    id << cas.id
                end
                
                casa = House.find(id.min)
                
                puts "Digite o novo city"
                new = gets.chomp
                casa.update(city: new)
            else
                puts "City invalida"
            end
        end
        
        if dados.include?('state')
            i = dados.index('state') + 2
            temp = dados[dados.index('state')+1]
            while (i < dados.size) do
                if (upperDow(dados[i]))
                    break
                else
                    dados[dados.index('state')+1] = temp << " " << dados[i]
                    i += 1
                end
            end
            
            casas = House.where(:state => dados[dados.index('state')+1])
            if (casas!=nil)    
                casas.each do |cas|
                    id << cas.id
                end
                
                casa = House.find(id.min)
                puts "Digite o novo state"
                new = gets.chomp
                casa.update(state: new)
            else
                puts "State invalido"
            end
        end
        
        if dados.include?('country')
            i = dados.index('country') + 2
            temp = dados[dados.index('country')+1]
            while (i < dados.size) do
                if (upperDow(dados[i]))
                    break
                else
                    dados[dados.index('country')+1] = temp << " " << dados[i]
                    i += 1
                end
            end
            
            casas = House.where(:country => dados[dados.index('country')+1])
            if (casas!=nil)    
                casas.each do |cas|
                    id << cas.id
                end
                
                casa = House.find(id.min)

                puts "Digite o novo country"
                new = gets.chomp
                casa.update(country: new)
            else
                puts "Country invalido"
            end
        end
        puts "Registro alterado com sucesso"
        p casa
    rescue Exeption
        puts "Existem campos inválidos"
    end
end

def alteraDados(dados)
    case dados[1]
        when "pessoas"
            alteraPessoa(dados)
        when "profissoes"
            alteraProfissao(dados)
        when "sapatos"
            alteraSapatos(dados)
        when "casas"
            alteraCasas(dados)
        else
            puts "Tabela inválida"
    end
end

def excluiPessoa(dados)
    begin
        if dados.include?('last_name')
            i = dados.index('last_name') + 2
            temp = dados[dados.index('last_name')+1]
            while (i < dados.size) do
                if (upperDow(dados[i]))
                    break
                else
                    dados[dados.index('last_name')+1] = temp << " " << dados[i]
                    i += 1
                end
            end
            
            pessoas = Person.where(:last_name => dados[dados.index('last_name')+1])
            
            if (pessoas!=nil)    
                pessoas.each do |pes|
                    pes.destroy()
                end
            else
                puts "Last Name invalido"
            end
        end
        
        if dados.include?('first_name')
            i = dados.index('first_name') + 2
            temp = dados[dados.index('first_name')+1]
            while (i < dados.size) do
                if (upperDow(dados[i]))
                    break
                else
                    dados[dados.index('first_name')+1] = temp << " " << dados[i]
                    i += 1
                end
            end
            
            pessoas = Person.where(:first_name => dados[dados.index('first_name')+1])
            
            if (pessoas!=nil)    
                pessoas.each do |pes|
                    pes.destroy()
                end
            else
                puts "First Name invalido"
            end
        end
        
        if dados.include?('address')
            i = dados.index('address') + 2
            temp = dados[dados.index('address')+1]
            while (i < dados.size) do
                if (upperDow(dados[i]))
                    break
                else
                    dados[dados.index('address')+1] = temp << " " << dados[i]
                    i += 1
                end
            end
            
            pessoas = Person.where(:address => dados[dados.index('address')+1])
            if (pessoas!=nil)
                pessoas.each do |pes|
                    pes.destroy()
                end
            else
                puts "Address invalido"
            end
        end
        
        if dados.include?('city')
            i = dados.index('city') + 2
            temp = dados[dados.index('city')+1]
            while (i < dados.size) do
                if (upperDow(dados[i]))
                    break
                else
                    dados[dados.index('city')+1] = temp << " " << dados[i]
                    i += 1
                end
            end
            
            pessoas = Person.where(:city => dados[dados.index('city')+1])
            
            if (pessoas!=nil)   
                pessoas.each do |pes|
                    pes.destroy()
                end
            else
                puts "City invalido"
            end
        end
        puts "Registro excluido com sucesso"
    rescue Exception
        puts "Existem campos inválidos"
    end
end

def excluiProfissao(dados)
    begin
        if dados.include?('name_profession')
            i = dados.index('name_profession') + 2
            temp = dados[dados.index('name_profession')+1]
            while (i < dados.size) do
                if (upperDow(dados[i]))
                    break
                else
                    dados[dados.index('name_profession')+1] = temp << " " << dados[i]
                    i += 1
                end
            end
            
            profissoes = Profession.where(:name_profession => dados[dados.index('name_profession')+1])
            if (profissoes!=nil)
                profissoes.each do |prof|
                    prof.destroy()
                end
            else
                puts "Name Profession invalido"
            end
        end
        
        if dados.include?('area_acting')
            i = dados.index('area_acting') + 2
            temp = dados[dados.index('area_acting')+1]
            while (i < dados.size) do
                if (upperDow(dados[i]))
                    break
                else
                    dados[dados.index('area_acting')+1] = temp << " " << dados[i]
                    i += 1
                end
            end
            
            profissoes = Profession.where(:area_acting => dados[dados.index('area_acting')+1])
            if (profissoes!=nil)
                profissoes.each do |prof|
                    prof.destroy()
                end
            else
                puts "Area Acting invalido"
            end
        end
    
        puts "Registro excluido com sucesso"
    rescue Exception
        puts "Existem campos inválidos"
    end
end

def excluiSapatos(dados)
    begin
        if dados.include?('number')
            sapatos = Shoe.where(:number => dados[dados.index('number')+1])
            if (sapatos!=nil)
                sapatos.each do |sap|
                    sap.destroy()
                end
            else
                puts "Number invalido"
            end
        end
        
        if dados.include?('color')
            i = dados.index('color') + 2
            temp = dados[dados.index('color')+1]
            while (i < dados.size) do
                if (upperDow(dados[i]))
                    break
                else
                    dados[dados.index('color')+1] = temp << " " << dados[i]
                    i += 1
                end
            end
            
            sapatos = Shoe.where(:color => dados[dados.index('color')+1])
            if (sapatos!=nil)    
                sapatos.each do |sap|
                    sap.destroy()
                end
            else
                puts "Color invalido"
            end
        end
        puts "Registro excluido com sucesso"
    rescue Exception
        puts "Existem campos inválidos"
    end
end

def excluiCasas(dados)
    begin
        if dados.include?('address')
            i = dados.index('address') + 2
            temp = dados[dados.index('address')+1]
            while (i < dados.size) do
                if (upperDow(dados[i]))
                    break
                else
                    dados[dados.index('address')+1] = temp << " " << dados[i]
                    i += 1
                end
            end
            
            casas = House.where(:address => dados[dados.index('address')+1])
            
            if (casas!=nil)
                casas.each do |cas|
                    cas.destroy()
                end
            else
                puts "Address invalido"
            end
        end
        
        if dados.include?('city')
            i = dados.index('city') + 2
            temp = dados[dados.index('city')+1]
            while (i < dados.size) do
                if (upperDow(dados[i]))
                    break
                else
                    dados[dados.index('city')+1] = temp << " " << dados[i]
                    i += 1
                end
            end
            casas = House.where(:city => dados[dados.index('city')+1])
                
            if (casas!=nil)
                casas.each do |cas|
                    cas.destroy()
                end
            else
                puts "City invalida"
            end
        end
        
        if dados.include?('state')
            i = dados.index('state') + 2
            temp = dados[dados.index('state')+1]
            while (i < dados.size) do
                if (upperDow(dados[i]))
                    break
                else
                    dados[dados.index('state')+1] = temp << " " << dados[i]
                    i += 1
                end
            end
            
            casas = House.where(:state => dados[dados.index('state')+1])
                
            if (casas!=nil)
                casas.each do |cas|
                    cas.destroy()
                end
            else
                puts "State invalido"
            end
        end
        
        if dados.include?('country')
            i = dados.index('country') + 2
            temp = dados[dados.index('country')+1]
            while (i < dados.size) do
                if (upperDow(dados[i]))
                    break
                else
                    dados[dados.index('country')+1] = temp << " " << dados[i]
                    i += 1
                end
            end
            
            casas = House.where(:country => dados[dados.index('country')+1])
                
            if (casas!=nil)
                casas.each do |cas|
                    cas.destroy()
                end
            else
                puts "Country invalido"
            end
        end
        puts "Registro excluido com sucesso"
    rescue Exception
        puts "Existem campos inválidos"
    end
end

def excluiDados(dados)
    case dados[1]
        when "pessoas"
            excluiPessoa(dados)
        when "profissoes"
            excluiProfissao(dados)
        when "sapatos"
            excluiSapatos(dados)
        when "casas"
            excluiCasas(dados)
        else
            puts "Tabela inválida"
    end
end

def listaPessoa
    pessoas = Person.all;
    pessoas.each do |p|
        puts "#{p.id}, #{p.last_name}, #{p.first_name}, #{p.address}, #{p.city}"
    end
end

def listaProfissao
    profissoes = Profession.all;
    profissoes.each do |p|
        puts "#{p.id}, #{p.person}, #{p.name_profession}, #{p.area_acting}"
    end
end

def listaSapatos
    sapatos = Shoe.all;
    sapatos.each do |p|
        puts "#{p.id}, #{p.person}, #{p.number}, #{p.color}"
    end
end

def listaCasas
    casas = House.all;
    casas.each do |p|
        puts "#{p.id}, #{p.persons}, #{p.address}, #{p.city}, #{p.state}, #{p.country}"
    end
end

def listaDados(dados)
    case dados[1]
        when "pessoas"
            listaPessoa
        when "profissoes"
            listaProfissao
        when "sapatos"
            listaSapatos
        when "casas"
            listaCasas
        else
            puts "Tabela inválida"
    end
end

puts "Olá, Bem-vindo."
puts "================================"
puts "Que operação deseja fazer?"
puts "(1) Inserir Dados,"
puts "(2) Alterar Dados,"
puts "(3) Excluir Dados,"
puts "(4) Listar Dados."
puts "================================"
puts "Argumentos de entrada"
puts "< operação > < tabela > { atributo = valor }"
puts "================================"
puts "Exemplos de Entradas"
puts "insere pessoas last_name=""Svendson"" first_name=""Tove"" address=""Borgvn 23"" city=""Sandnes"""
puts "altera pessoas last_name=""Murray"""
puts "exclui pessoas last_name=""Svendson"""
puts "lista pessoas"
puts "exit"
puts "================================"
puts "Digite um comando valido: \n"

loop do
    dados = gets.split(/[ \=\n]/)
    dados = dados.map { |i| i.tr('\"', '') }
    case dados[0]
        when "insere"
            insereDados(dados)
        when "altera"
            alteraDados(dados)
        when "exclui"
            excluiDados(dados)
        when "lista"
            listaDados(dados)
        when "exit"
            puts "Saindo..."
            break
        else
            puts "Opção inválida."
    end
    print "\n"
    puts "Entre com um novo comando"
    print "\n"
end    