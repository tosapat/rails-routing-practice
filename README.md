Rails Routing Practice
======================

This simple app lets students learning Rails get some practice
understanding how routes from `config/routes.rb` are parsed.

The learner enters some `config/routes.rb`-compliant route descriptions,
and can then enter various routes (method + URI) to see how they would
be recognized and how `params` would be parsed from them.

Everything here is [CC-BY-NC-SA](https://creativecommons.org/licenses/by-nc-sa/4.0/legalcode).


รัน code แล้วคลิกลิ้ง http://rails-routing-practice.saasbook.info
แล้วทดสอบเว็บไซต์โดยใช้

resources :products, only: [:index, :show]
resources :brands, only: [:index, :show] 
resource :basket, only: [:show, :update, :destroy]

พิมลงไปในช่องสี่เหลี่ยมที่อยู่ภายในเว็บไซด์
