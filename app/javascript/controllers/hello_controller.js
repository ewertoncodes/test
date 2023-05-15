import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["zipcode", "street", "complement", "neighborhood", "city", "state", "ibgeCode"]
    
  lookup = async () => {
    const zipcode = this.element.value
    const response = await fetch(`https://viacep.com.br/ws/${zipcode}/json/`)
    const data = await response.json()

    console.log(data)

    const streetInput = document.querySelector('[data-target="hello.street"]');
    streetInput.value = data.logradouro

    const complementInput = document.querySelector('[data-target="hello.complement"]');
    complementInput.value = data.complemento
    
    const neighborhoodInput = document.querySelector('[data-target="hello.neighborhood"]');
    neighborhoodInput.value = data.bairro

    const cityInput = document.querySelector('[data-target="hello.city"]');
    cityInput.value = data.localidade

    const stateInput = document.querySelector('[data-target="hello.state"]');
    stateInput.value = data.uf
    
    const ibgeInput = document.querySelector('[data-target="hello.ibge_code"]');
    ibgeInput.value = data.ibge

  }
}