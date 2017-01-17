package com.borhan.Live.infra

import com.datastax.driver.core.Cluster
import com.borhan.Live.env.EnvParams
import com.borhan.Live.model.dao.{LoggedData, LoggedDataCF}
import com.borhan.Live.utils.{BaseLog, MetaLog}

import scala.concurrent.Await


object EventsFileExtractor extends Serializable with MetaLog[BaseLog]
{
     def metaLog = EventsFileExtractor

     def extractData( data: Option[LoggedData]) = data match {
          case Some(s) => s
          case None => "?"
     }

//     val cluster = Cluster.builder().addContactPoint(EnvParams.cassandraAddress).build()
//     val session = cluster.connect(EnvParams.borhanKeySpace)

     def fileIdToLines( fileId: String ) : List[String] =
     {
          //val rdd: SchemaRDD = cc.sql( "SELECT data from borhan_live.log_data WHERE file_id='" + fileId + "'" )
          // val lines = rdd.flatMap(row => blobToLines(row(0) ) ).collect().toList

//          val cluster = Cluster.builder().addContactPoint(EnvParams.cassandraAddress).build()
//          val session = cluster.connect(EnvParams.borhanKeySpace)

          val loggedDataCF = new LoggedDataCF(SerializedSession.session)

          val blob = Await.result(loggedDataCF.selectFile(fileId), scala.concurrent.duration.Duration.Inf)

          var lines: List[String] = List.empty
          if ( blob == None )
          {
               logger.warn(s"file id: $fileId, not found", fileId)
               return lines
          }

          lines = BlobExtractor.blobToLines(blob.get.data)

          if ( lines.isEmpty )
               logger.warn(s"file id: $fileId, no lines found", fileId)

          lines
     }
}
