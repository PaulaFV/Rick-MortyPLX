//
//  ListaPersonajesViewModel.swift
//  Rick-MortyPLX-Ainhoa
//
//  Created by Ainhoa  on 20/5/25.
//

import Foundation
import Combine

class ListaPersonajesViewModel: ProtocoloViewModel {
    
    var personajes: [Personaje] = []
    private var cancelables: Set<AnyCancellable> = []
    private let servicioAPI: ProtocoloAPI
    
    init (servicioAPI: ProtocoloAPI = ServicioAPI()) {
        self.servicioAPI = servicioAPI
    }
    
    func buscarPersonajes() {
        servicioAPI.obtenerPersonajes()
            .sink(receiveCompletion: { _ in },
                  receiveValue: { personajes in
                self.personajes = personajes
            })
            .store(in: &cancelables)
    }
    
    func obtenerPersonaje(en indice: Int) -> Personaje {
        return personajes[indice]
    }
}
