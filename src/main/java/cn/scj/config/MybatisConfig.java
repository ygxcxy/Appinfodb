package cn.scj.config;

import com.alibaba.druid.pool.DruidDataSource;
import com.github.pagehelper.PageInterceptor;
import org.mybatis.spring.SqlSessionFactoryBean;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.PropertySource;
import org.springframework.core.io.support.PathMatchingResourcePatternResolver;
import org.springframework.jdbc.datasource.DataSourceTransactionManager;
import tk.mybatis.mapper.common.Mapper;
import tk.mybatis.mapper.entity.Config;
import tk.mybatis.mapper.mapperhelper.MapperHelper;
import tk.mybatis.spring.annotation.MapperScan;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.Properties;

@Configuration
@PropertySource(value = "classpath:db.properties")//配置properties数据源
@MapperScan(value = { "tk.mybatis.mapper.annotation","cn.scj.mapper"}, mapperHelperRef = "mapperHelper")//配置扫描接口
public class MybatisConfig {

    @Value("${db.url}")//为这些数据赋初始值
    private String url;
    @Value("${db.driver}")
    private String driver;
    @Value("${db.user}")
    private String user;
    @Value("${db.password}")
    private String password;


    //注册数据源
    @Bean(name = "dataSource")
    public DruidDataSource dataSource(){
        DruidDataSource druidDataSource = new DruidDataSource();
        druidDataSource.setUrl(url);
        druidDataSource.setDriverClassName(driver);
        druidDataSource.setUsername(user);
        druidDataSource.setPassword(password);
        return druidDataSource;
    }
    //注册会话工厂
    @Bean("sessionFactoryBean")
    public SqlSessionFactoryBean sessionFactoryBean(){
        SqlSessionFactoryBean sessionFactoryBean = new SqlSessionFactoryBean();
        sessionFactoryBean.setDataSource(dataSource());
        //设置mapper 文件映射
        PathMatchingResourcePatternResolver patternResolver = new PathMatchingResourcePatternResolver();
        try {
            sessionFactoryBean.setMapperLocations(patternResolver.getResources("classpath:mapper/**/*.xml"));
        } catch (IOException e) {
            e.printStackTrace();
        }
        PageInterceptor pageInterceptor = new PageInterceptor();
        Properties properties = new Properties();
        properties.setProperty("helperDialect","mysql");//用哪个数据库
        properties.setProperty("reasonable","true");//用哪个数据库
        properties.setProperty("supportMethodsArguments","true");//用哪个数据库
        properties.setProperty("params","count=countSql");//用哪个数据库
        properties.setProperty("autoRuntimeDialect","true");//用哪个数据库
        pageInterceptor.setProperties(properties);
        sessionFactoryBean.setPlugins(pageInterceptor);//设置插件
        //mybatis 一些系统配置
        org.apache.ibatis.session.Configuration cfg = new org.apache.ibatis.session.Configuration();
        cfg.setMapUnderscoreToCamelCase(true);//继续,字段名驼峰命名
        sessionFactoryBean.setConfiguration(cfg);//配置完毕
        return sessionFactoryBean;
    }
    //注册事务
    @Bean("transactionManager")
    public DataSourceTransactionManager transactionManager(){
        DataSourceTransactionManager dataSourceTransactionManager = new DataSourceTransactionManager();
        dataSourceTransactionManager.setDataSource(dataSource());
        return dataSourceTransactionManager;
    }
    @Bean
    public MapperHelper mapperHelper() {
        Config config = new Config();
        List<Class> mappers = new ArrayList<Class>();
        mappers.add(Mapper.class);
        config.setMappers(mappers);

        MapperHelper mapperHelper = new MapperHelper();
        mapperHelper.setConfig(config);
        return mapperHelper;
    }
}
