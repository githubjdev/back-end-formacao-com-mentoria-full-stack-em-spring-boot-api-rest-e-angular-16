package jdev.mentoria.lojavirtual.model.dto;

import java.util.ArrayList;
import java.util.List;

/**
 * Classe principal retorno da cobrança da API Asaas
 * @author alex_
 *
 */
public class CobrancaGeradaAsassApi {

	private String object;
	private Boolean hasMore;
	private Integer totalCount;
	private Integer limit;
	private Integer offset;

	private List<CobrancaGeradaAssasData> data = new ArrayList<CobrancaGeradaAssasData>();

	public String getObject() {
		return object;
	}

	public void setObject(String object) {
		this.object = object;
	}

	public Boolean getHasMore() {
		return hasMore;
	}

	public void setHasMore(Boolean hasMore) {
		this.hasMore = hasMore;
	}

	public Integer getTotalCount() {
		return totalCount;
	}

	public void setTotalCount(Integer totalCount) {
		this.totalCount = totalCount;
	}

	public Integer getLimit() {
		return limit;
	}

	public void setLimit(Integer limit) {
		this.limit = limit;
	}

	public Integer getOffset() {
		return offset;
	}

	public void setOffset(Integer offset) {
		this.offset = offset;
	}

	public List<CobrancaGeradaAssasData> getData() {
		return data;
	}

	public void setData(List<CobrancaGeradaAssasData> data) {
		this.data = data;
	}

}
