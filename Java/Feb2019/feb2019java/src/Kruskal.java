/**----------------------------------------------
 * -- Estructuras de Datos.  2018/19
 * -- 2Âº Curso del Grado en IngenierÃ­a del Software.
 * -- Escuela TÃ©cnica Superior de IngenierÃ­a en InformÃ¡tica. UMA
 * --
 * -- Examen 4 de febrero de 2019
 * --
 * -- ALUMNO/NAME: Ã�lvaro AlemÃ¡n Rando
 * -- GRADO/STUDIES: Ing. del Software
 * --
 * --
 * ----------------------------------------------
 */

import dataStructures.graph.WeightedGraph;
import dataStructures.graph.WeightedGraph.WeightedEdge;

import dataStructures.dictionary.Dictionary;
import dataStructures.dictionary.HashDictionary;
import dataStructures.priorityQueue.PriorityQueue;
import dataStructures.priorityQueue.LinkedPriorityQueue;
import dataStructures.set.Set;
import dataStructures.set.HashSet;

import java.util.Iterator;

public class Kruskal {
	public static <V,W> Set<WeightedEdge<V,W>> kruskal(WeightedGraph<V,W> g) {

		// COMPLETAR

		Set<WeightedEdge<V,W>> T = new HashSet<>(); //Conjunto de ExpansiÃ³n mÃ­nima, aquÃ­ iremos introduciendo el bosque generado. 

		PriorityQueue<WeightedEdge<V,W>> PQ = new LinkedPriorityQueue<>(); //Creamos la PQ (Lista de prioridad, donde iremos consultando las aristas de menor coste)
		for(WeightedEdge<V,W> we : g.edges()){
			PQ.enqueue(we);
		}
		
		//Creamos el diccionario DICT y le aÃ±adimos los vertices
		Dictionary<V,V> DICT = new HashDictionary<>();  
		for (V v : g.vertices()){
			DICT.insert(v,v);
		}

		while (PQ.isEmpty() == false){
				WeightedEdge<V,W> first = PQ.first();
				PQ.dequeue();
				V r1 = getRepresentante(first.source(), DICT);
				V r2 = getRepresentante(first.destination(), DICT);

				if (r1 != r2){
					DICT.insert(r2, first.source());
					T.insert(first);
				}
		}

		
		return T;
	}

	private static <V> V getRepresentante (V srce, Dictionary<V,V> DICT){
		V sours = srce;
		V dst = DICT.valueOf(srce);
		
		while (!dst.equals(sours)){
			sours = srce;
			dst = DICT.valueOf(sours);
		}
		return dst;
	}
	
}
