#!/bin/env ruby
# -*- coding: utf-8 -*-
# Cria uma nova base de dados a cada vez. 
# Para criar o bd execute "ruby criaSchema.rb".

require 'rubygems'
require 'active_record'

# As duas linhas abaixo indicam o SGBD a ser usado (sqlite3) e o nome
# do arquivo que contém o banco de dados (Aulas.sqlite3)
ActiveRecord::Base.establish_connection :adapter => "sqlite3",
                                        :database => "Database.sqlite3" 
                    
# As linhas abaixo criam a tabela "pessoas" dentro do banco
# "Aulas.sqlite3", indicando os atributos e os seus tipos. No caso,
# todos são "string", mas tem várias outras oportunidades.
ActiveRecord::Base.connection.create_table :people do |t|  
  t.string       :last_name 
  t.string       :first_name 
  t.string       :address 
  t.string       :city
end

=begin
----->>>> 
----- Dica de como implementar relações:
1x1 (Pessoa Profissão)
1xn (Pessoa Sapatos)
nxn (Pessoa Casa)
----->>>> 
=end

# Sugestão de bibliografia:
# http://www.amazon.com/Pro-Active-Record-Databases-Experts/dp/1590598474

ActiveRecord::Base.connection.create_table :professions do |t|  
  t.references   :person 
  t.string       :name_profession 
  t.string       :area_acting 
end

ActiveRecord::Base.connection.create_table :shoes do |t|  
  t.references   :person
  t.integer      :number 
  t.string       :color  
end

ActiveRecord::Base.connection.create_table :houses do |t|  
  t.string   :address
  t.string   :city
  t.string   :state 
  t.string   :country
end

ActiveRecord::Base.connection.create_table :houses_people do |t|  
  t.references   :person, :house
end
