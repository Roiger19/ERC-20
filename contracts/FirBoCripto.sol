// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

/// @title Contrato de Token ERC-20 "FirBoCripto"
/// @author Juan Pablo (Estudiante de Ingeniería)
/// @notice Contrato básico para crear un token con funciones de acuñado y quemado controlado.
/// @dev Hereda de OpenZeppelin ERC20 y Ownable para seguridad estándar.
contract FirBoCripto is ERC20, Ownable {

    /// @notice Se ejecuta una sola vez al desplegar el contrato.
    /// @dev Inicializa el token con nombre, símbolo y asigna el dueño inicial.
    /// @param initialOwner La dirección de la billetera que será dueña del contrato (Admin).
    constructor(address initialOwner) 
        ERC20("FirBoCripto", "FIRBO") 
        Ownable(initialOwner)
    {
        // Explicación Sintaxis:
        // 1. _mint: Función interna heredada de ERC20.
        // 2. msg.sender: La persona que está desplegando el contrato (tú).
        // 3. 10 ** decimals(): Multiplica por 10^18 para ajustar los decimales de Solidity.
        _mint(msg.sender, 1000000 * 10 ** decimals());
    }

    /// @notice Permite crear nuevos tokens (Inflación).
    /// @dev Solo puede ser ejecutada por el dueño del contrato (modificador onlyOwner).
    /// @param to La dirección de la billetera que recibirá los tokens nuevos.
    /// @param amount La cantidad de tokens a crear (recuerda los 18 decimales).
    function mint(address to, uint256 amount) public onlyOwner {
        _mint(to, amount);
    }

    /// @notice Permite a cualquier usuario destruir sus propios tokens (Deflación).
    /// @dev Reduce el 'totalSupply' del token. No requiere onlyOwner.
    /// @param amount La cantidad de tokens a quemar.
    function burn(uint256 amount) public {
        _burn(msg.sender, amount);
    }
}
