package com.borhan.live.model.aggregation.filter;

import java.util.Date;
import java.util.concurrent.TimeUnit;

import com.borhan.live.infra.utils.DateUtils;
import com.borhan.live.infra.utils.LiveConfiguration;

public class StatsEventsRealTimeFilter extends StatsEventsFilter {

	private static final long serialVersionUID = -1029156680788096287L;

	@Override
	protected Date getLatestTimeToSave() {
		return new Date(DateUtils.getCurrentMinInMillis() - TimeUnit.MINUTES.toMillis(LiveConfiguration.instance().getMinutesToSave()));
	}

}
